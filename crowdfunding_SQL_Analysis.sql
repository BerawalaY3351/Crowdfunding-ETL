-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id, backers_count
FROM campaign
WHERE outcome = 'live'
ORDER BY backers_count DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT DISTINCT bck.cf_id, cpg.backers_count
FROM backers AS bck
JOIN campaign AS cpg
ON cpg.cf_id = bck.cf_id
WHERE cpg.outcome = 'live'
ORDER BY cpg.backers_count DESC
GROUP BY cf_id;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT c.first_name, c.last_name, c.email, 
		(cpg.goal - cpg.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM campaign AS cpg
JOIN contacts AS c
ON cpg.contact_id = c.contact_id
WHERE outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;



-- Check the table
Select * FROM email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT 	email as "Email Address",
		first_name as "First name",
		last_name as "Last name",
		b.cf_id as "CF ID", 
		c.company_name "Company name", 
		c.description "Description", 
		c.end_date "End Date",
		(CAST(c.goal as double PRECISION) - CAST(c.pledged as double PRECISION)) as "Left of Goal"
INTO "email_backers_remaining_goal_amount"
FROM backers b
LEFT JOIN campaign c on b.cf_id = c.cf_id
ORDER BY last_name ASC;


-- Check the table
SELECT * FROM email_backers_remaining_goal_amount