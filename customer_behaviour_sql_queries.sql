SELECT * FROM customer_behaviour.customer;

-- 1)Get gender-wise total revenue
SELECT Gender, 
       SUM(`Purchase Amount (USD)`) AS revenue
FROM customer
GROUP BY Gender;
--2)
SELECT 
    `Customer ID`, 
    `Purchase Amount (USD)`
FROM customer
WHERE 
    `Discount Applied` = 'Yes'
    AND `Purchase Amount (USD)` >= (
        SELECT AVG(`Purchase Amount (USD)`)
        FROM customer
    );
--2)which customer used a discount but still spent more than the average
review rating 
SELECT 
    `Customer ID`, 
    `Purchase Amount (USD)`
FROM customer
WHERE 
    `Discount Applied` = 'Yes'
    AND `Purchase Amount (USD)` >= (
        SELECT AVG(`Purchase Amount (USD)`)
        FROM customer
    );
--3)which are the top 5 products with the highest averae review rating ?
SELECT 
    `Item Purchased`,
    ROUND(AVG(CAST(`Review Rating` AS DECIMAL(10,2))), 2) AS `Average Product Rating`
FROM customer
GROUP BY `Item Purchased`
ORDER BY AVG(CAST(`Review Rating` AS DECIMAL(10,2))) DESC
LIMIT 5;
--3)
SELECT 
    `Shipping Type`,
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS Avg_Purchase_Amount
FROM customer
WHERE `Shipping Type` IN ('Standard', 'Express')
GROUP BY `Shipping Type`;
--5)
SELECT 
    `Subscription Status`,
    COUNT(`Customer ID`) AS total_customers,
    ROUND(AVG(`Purchase Amount (USD)`), 2) AS avg_spend,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS total_revenue
FROM customer
GROUP BY `Subscription Status`
ORDER BY total_revenue DESC, avg_spend DESC;
6)
SELECT 
    `Item Purchased`,
    ROUND(
        (SUM(CASE WHEN `Discount Applied` = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(*) * 100),
        2
    ) AS discount_rate
FROM customer
GROUP BY `Item Purchased`
ORDER BY discount_rate DESC
LIMIT 5;
--7)
WITH customer_type AS (
    SELECT 
        `Customer ID`,
        `Previous Purchases`,
        CASE 
            WHEN `Previous Purchases` = 1 THEN 'New'
            WHEN `Previous Purchases` BETWEEN 2 AND 10 THEN 'Returning'
            ELSE 'Loyal'
        END AS customer_segment
    FROM customer
)
SELECT 
    customer_segment,
    COUNT(*) AS `Number of Customers`
FROM customer_type
GROUP BY customer_segment;

8)
WITH item_counts AS (
    SELECT 
        `Category`,
        `Item Purchased`,
        COUNT(`Customer ID`) AS total_orders,
        ROW_NUMBER() OVER (
            PARTITION BY `Category`
            ORDER BY COUNT(`Customer ID`) DESC
        ) AS item_rank
    FROM customer
    GROUP BY `Category`, `Item Purchased`
)

SELECT 
    item_rank,
    `Category`,
    `Item Purchased`,
    total_orders
FROM item_counts
WHERE item_rank <= 3
ORDER BY `Category`, item_rank;
--9)
SELECT 
    `Subscription Status`,
    COUNT(`Customer ID`) AS repeat_buyers
FROM customer
WHERE `Previous Purchases` > 5
GROUP BY `Subscription Status`;
--10)
SELECT 
    CASE
        WHEN `Age` < 18 THEN 'Teen'
        WHEN `Age` BETWEEN 18 AND 29 THEN 'Young Adult'
        WHEN `Age` BETWEEN 30 AND 45 THEN 'Adult'
        WHEN `Age` BETWEEN 46 AND 60 THEN 'Middle Age'
        ELSE 'Senior'
    END AS age_group,

    SUM(`Purchase Amount (USD)`) AS total_revenue
FROM customer
GROUP BY age_group
ORDER BY total_revenue DESC;







