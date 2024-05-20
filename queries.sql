#3.1
SELECT  
    ch.chef_id, ch.first_name, ch.last_name, cu.cuisine_name, 
    AVG(cas.avg_grade) AS avg_score 
FROM  
    comp_avg_scores cas 
JOIN  
    cuisine cu ON cu.cuisine_id = cas.cuisine_id 
JOIN  
    chef ch ON ch.chef_id = cas.competitor_id 
GROUP BY  
    ch.chef_id, cu.cuisine_id;

#3.1a cooks

SELECT 
	c.first_name, 
    c.last_name, 
    AVG(cas.avg_grade) AS total_avg 
FROM 
	comp_avg_scores cas 
JOIN 
	chef c ON c.chef_id = cas.competitor_id 
GROUP BY 
	cas.competitor_id 

#3.1b cuisine

SELECT 
	c.cuisine_name, 
    AVG(cas.avg_grade) AS total_avg 
FROM 
	comp_avg_scores cas 
JOIN 
	cuisine c ON c.cuisine_id = cas.cuisine_id 
GROUP BY 
	cas.cuisine_id 
    

#3.2
SELECT  
    ch.first_name, ch.last_name, e.episode_year, cu.cuisine_name AS cuisine_name 
FROM  
    comp_cuisine cc 
JOIN  
    cuisine cu ON cu.cuisine_id = cc.cuisine_id 
JOIN  
    chef ch ON ch.chef_id = cc.competitor_id 
JOIN  
    episode e ON cas.episode_id = e.episode_id 
WHERE  
    cu.cuisine_name = 'Italian' AND e.episode_year = '2022';


#3.3

SELECT  
	ch.first_name, ch.last_name, 
    COUNT(r.recipe_id) as recipe_count 
FROM 
	chef ch 
JOIN 
	specializes sp ON sp.chef_id = ch.chef_id 
JOIN 
	recipe r ON r.cuisine_id = sp.cuisine_id 
WHERE 
	ch.age < 30 
GROUP BY 
	r.cuisine_id 
ORDER BY 
	recipe_count DESC; 


#3.4

SELECT ch.first_name, ch.last_name
FROM chef ch
LEFT JOIN is_graded ig ON ch.chef_id = ig.judge_id
WHERE ig.judge_id IS NULL;

#3.5

WITH judge_participations AS ( 
    SELECT  
        ig.judge_id, ch.first_name, ch.last_name, e.year AS episode_year,  
        COUNT(DISTINCT ig.episode_id) AS episode_count 
    FROM  
        is_graded ig 
    JOIN  
        episode e ON ig.episode_id = e.episode_id 
    JOIN  
        chef ch ON ig.judge_id = ch.chef_id 
    GROUP BY  
        ig.judge_id, e.episode_year 
    HAVING  
        COUNT(DISTINCT ig.episode_id) > 3 
) 
SELECT  
    jp1.judge_id AS judge_id1, 
    jp1.first_name AS first_name1, 
    jp1.last_name AS last_name1, 
    jp2.judge_id AS judge_id2, 
    jp2.first_name AS first_name2, 
    jp2.last_name AS last_name2, 
    jp1.episode_year, 
    jp1.episode_count 
FROM  
    judge_participations jp1 
JOIN  
    judge_participations jp2 ON jp1.episode_count = jp2.episode_count  
    AND jp1.episode_year = jp2.episode_year  
    AND jp1.judge_id <> jp2.judge_id 
ORDER BY  
    jp1.episode_year, jp1.episode_count;


#3.6

SELECT  
    rl1.label_id AS label1, rl2.label_id AS label2, 
    COUNT(*) AS appearance_count 
FROM  
    recipe_label rl1 
JOIN  
    recipe_label rl2 ON rl1.recipe_id = rl2.recipe_id AND rl1.label_id < rl2.label_id 
JOIN 
    is_assigned ia ON ia.recipe_id = rl1.recipe_id 
GROUP BY  
    rl1.label_id, rl2.label_id 
ORDER BY  
    appearance_count DESC 
LIMIT 3;

#alternative plan:

SELECT  
    rl1.label_id AS label1, rl2.label_id AS label2, 
    COUNT(*) AS appearance_count 
FROM  
    recipe_label rl1 FORCE INDEX (PRIMARY) 
JOIN  
    recipe_label rl2 FORCE INDEX (PRIMARY) 
    ON rl1.recipe_id = rl2.recipe_id AND rl1.label_id < rl2.label_id 
JOIN  
    is_assigned ia FORCE INDEX (is_assigned_recipe_FK) 
    ON ia.recipe_id = rl1.recipe_id 
GROUP BY  
    rl1.label_id, rl2.label_id 
ORDER BY  
    appearance_count DESC 
LIMIT 3;


#3.7
WITH chef_participations AS ( 
    SELECT  
        ia.competitor_id, 
        COUNT(ia.episode_id) AS episode_count 
    FROM  
        is_assigned ia 
    GROUP BY  
        ia.competitor_id 
), max_participation AS ( 
    SELECT  
        MAX(episode_count) AS max_count 
    FROM  
        chef_participations 
) 
SELECT 
    ch.first_name, 
    ch.last_name 
FROM  
    chef_participations cp 
JOIN  
    chef ch ON cp.competitor_id = ch.chef_id 
WHERE  
    cp.episode_count <= (SELECT max_count FROM max_participation) - 5;

#3.8

SELECT  
    e.episode_num, 
    COUNT(re.equipment_id) AS equipment_count 
FROM  
    episode e 
JOIN  
    is_assigned ia ON e.episode_id = ia.episode_id 
JOIN  
    recipe_equipment re ON ia.recipe_id = re.recipe_id 
GROUP BY  
    e.episode_id 
ORDER BY  
    equipment_count DESC 
LIMIT 1;

#alternative plan:

SELECT  
    e.episode_num, 
    COUNT(re.equipment_id) AS equipment_count 
FROM  
    episode e FORCE INDEX (PRIMARY) 
JOIN  
    is_assigned ia FORCE INDEX (is_assigned_recipe_id_IDX) ON e.episode_id = ia.episode_id 
JOIN  
    recipe_equipment re FORCE INDEX (PRIMARY) ON ia.recipe_id = re.recipe_id 
GROUP BY  
    e.episode_id 
ORDER BY  
    equipment_count DESC 
LIMIT 1;

#3.9

SELECT  
    e.episode_year, 
    AVG(COALESCE(r.carbs_g, 0)) AS avg_carbs 
FROM  
    recipe r 
JOIN  
    is_assigned ia ON r.recipe_id = ia.recipe_id 
JOIN  
    episode e ON ia.episode_id = e.episode_id 
GROUP BY  
    e.episode_year;

#3.10

WITH yearly_participations AS ( 
    SELECT  
        cc.cuisine_id, 
        e.episode_year, 
        COUNT(DISTINCT e.episode_id) AS participation_count 
    FROM  
        comp_cuisine cc 
    JOIN  
        episode e ON cc.episode_id = e.episode_id 
    GROUP BY  
        cc.cuisine_id, e.episode_year 
    HAVING  
        COUNT(DISTINCT e.episode_id) >= 3 
) 
SELECT  
    yp1.cuisine_id, 
    yp1.episode_year, 
    yp2.episode_year AS next_year, 
    yp1.participation_count 
FROM  
    yearly_participations yp1 
JOIN  
    yearly_participations yp2 ON yp1.cuisine_id = yp2.cuisine_id 
    AND yp1.episode_year = yp2.episode_year - 1 
WHERE  
    yp1.participation_count = yp2.participation_count;

#3.11

SELECT  
    ig.judge_id, 
    j.first_name AS judge_first_name, 
    j.last_name AS judge_last_name, 
    ig.competitor_id, 
    c.first_name AS competitor_first_name, 
    c.last_name AS competitor_last_name, 
    SUM(ig.grade) AS total_score 
FROM  
    is_graded ig 
JOIN  
    chef j ON ig.judge_id = j.chef_id 
JOIN  
    chef c ON ig.competitor_id = c.chef_id 
GROUP BY  
    ig.judge_id, ig.competitor_id 
ORDER BY  
    total_score DESC 
LIMIT 5;


#3.12

WITH episode_difficulties AS ( 
    SELECT  
        e.episode_year, 
        e.episode_num, 
        SUM(r.difficulty) AS total_difficulty 
    FROM  
        episode e 
    JOIN  
        is_assigned ia ON e.episode_id = ia.episode_id 
    JOIN  
        recipe r ON ia.recipe_id = r.recipe_id 
    GROUP BY  
        e.episode_year, e.episode_num 
) 
SELECT  
    ed.episode_year, 
    ed.episode_num, 
    ed.total_difficulty 
FROM  
    episode_difficulties ed 
JOIN  
    ( 
        SELECT  
            episode_year, 
            MAX(total_difficulty) AS max_difficulty 
        FROM  
            episode_difficulties 
        GROUP BY  
            episode_year 
    ) md ON ed.episode_year = md.episode_year AND ed.total_difficulty = md.max_difficulty 
ORDER BY  
    ed.episode_year;

#3.13

WITH competitor_ranks AS ( 
    SELECT  
        e.episode_id, 
        SUM(CASE ch.chef_rank 
            WHEN 'Cook C' THEN 1 
            WHEN 'Cook B' THEN 2 
            WHEN 'Cook A' THEN 3 
            WHEN 'Sous Chef' THEN 4 
            WHEN 'Chef' THEN 5 
            ELSE 0 
        END) AS total_competitor_rank 
    FROM  
        episode e 
    JOIN  
        is_assigned ia ON e.episode_id = ia.episode_id 
    JOIN  
        chef ch ON ia.competitor_id = ch.chef_id 
    GROUP BY  
        e.episode_id 
), 
judge_ranks AS ( 
    SELECT  
        e.episode_id, 
        SUM(CASE ch.chef_rank 
            WHEN 'Cook C' THEN 1 
            WHEN 'Cook B' THEN 2 
            WHEN 'Cook A' THEN 3 
            WHEN 'Sous Chef' THEN 4 
            WHEN 'Chef' THEN 5 
            ELSE 0 
        END) AS total_judge_rank 
    FROM  
        episode e 
    JOIN  
        is_graded ig ON e.episode_id = ig.episode_id 
    JOIN  
        chef ch ON ig.judge_id = ch.chef_id 
    GROUP BY  
        e.episode_id 
) 
SELECT  
    e.episode_id, 
    cr.total_competitor_rank + jr.total_judge_rank AS total_rank 
FROM  
    episode e 
JOIN  
    competitor_ranks cr ON e.episode_id = cr.episode_id 
JOIN  
    judge_ranks jr ON e.episode_id = jr.episode_id 
ORDER BY  
    total_rank ASC 
LIMIT 1;

#3.14

SELECT  
    tu.them_unit_name, 
    COUNT(*) AS theme_count 
FROM  
    them_unit tu 
JOIN  
    recipe_them_unit rtu ON tu.them_unit_id = rtu.them_unit_id 
JOIN  
    is_assigned ia ON rtu.recipe_id = ia.recipe_id 
GROUP BY  
    tu.them_unit_id 
ORDER BY  
    theme_count DESC 
LIMIT 1;

#3.15

SELECT  
    fg.food_group_name 
FROM  
    food_group fg 
LEFT JOIN  
    ingredient i ON fg.food_group_id = i.food_group_id 
LEFT JOIN 
