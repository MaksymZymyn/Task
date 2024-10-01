SELECT * FROM `sheet a`;

/*
# Campaign id, status, hits, cost
'1843579', 'Paused', '', '0'
'1120520', 'Running', '119298', '3.5189971'
'1531913', 'Running', '3366', '0.409261592'
'1522191', 'Running', '6', '0.001059'
'1258260', 'Running', '291989', '36.1597147'
'1258266', 'Paused', '', '0'
'1124638', 'Running', '721533', '34.8'
'1431081', 'Paused', '', '0'

458 row(s) returned
*/

SELECT * FROM `sheet b`;

/*
# Campign Id, Visits, Clicks, Conversions, Revenue, CTR, CR, CV, EPV, EPC, AP
'1488427', '23090', '1635', '214', '452.8', '0.07081', '0.130887', '0.009268', '0.0196', '0.2769', '2.1159'
'1712099', '24047', '2337', '213', '625.4', '0.097185', '0.091142', '0.008858', '0.026', '0.2676', '2.9362'
'1769695', '8610', '2459', '204', '517.8', '0.285598', '0.082961', '0.023693', '0.0601', '0.2106', '2.5382'
'1230758', '8469', '2101', '182', '452.9', '0.248081', '0.086625', '0.02149', '0.0535', '0.2156', '2.4885'
'1123894', '54418', '2173', '171', '432', '0.039932', '0.078693', '0.003142', '0.0079', '0.1988', '2.5263'
'1299303', '5691', '1588', '165', '404.0002', '0.279037', '0.103904', '0.028993', '0.071', '0.2544', '2.4485'
'1335457', '2734', '558', '139', '265.5', '0.204097', '0.249104', '0.050841', '0.0971', '0.4758', '1.9101'
'1807311', '3248', '1317', '124', '313.2', '0.40548', '0.094153', '0.038177', '0.0964', '0.2378', '2.5258'

239 row(s) returned
*/

CREATE TABLE campaign_performance (
    campaign_id VARCHAR(20),
    cost DECIMAL(15, 6),
    revenue DECIMAL(15, 6),
    profit DECIMAL(15, 6),
    roi DECIMAL(15, 2),
    conversions INT
);

INSERT INTO campaign_performance (campaign_id, cost, revenue, profit, roi, conversions)
SELECT 
    a.`Campaign id`, 
    SUM(a.cost) AS total_cost, 
    SUM(b.Revenue) AS total_revenue, 
    (SUM(b.Revenue) - SUM(a.cost)) AS total_profit, 
    CASE 
        WHEN SUM(a.cost) > 0 THEN ((SUM(b.Revenue) - SUM(a.cost)) / SUM(a.cost)) * 100 
        ELSE 0 
    END AS total_roi,
    SUM(b.Conversions) AS total_conversions
FROM `sheet a` a
LEFT JOIN `sheet b` b 
    ON (a.`Campaign id` = b.`Campign Id`)
GROUP BY a.`Campaign id`
ORDER BY a.`Campaign id`;


-- ROI (Return on Investment) measures the percentage return on the cost. It shows how much revenue was generated for every unit of currency spent.

SELECT * FROM campaign_performance;

/*
# campaign_id, cost, revenue, profit, roi, conversions
'1120520', '3.518997', '12.700000', '9.181003', '260.90', '5'
'1120848', '5.581132', '19.900000', '14.318868', '256.56', '8'
'1122910', '0.000000', NULL, NULL, '0.00', NULL
'1123894', '503.483631', '432.000000', '-71.483631', '-14.20', '171'
'1123898', '201.625738', '175.400000', '-26.225738', '-13.01', '70'
'1124638', '34.800000', '23.100000', '-11.700000', '-33.62', '9'
'1124660', '0.000000', NULL, NULL, '0.00', NULL
'1127260', '0.008460', NULL, NULL, NULL, NULL
'1230332', '0.000000', NULL, NULL, '0.00', NULL
'1230336', '0.000000', NULL, NULL, '0.00', NULL
'1230366', '32.999051', '38.450000', '5.450949', '16.52', '10'

458 row(s) returned
*/
