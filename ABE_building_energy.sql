-- Load top five rows of pre-retrofitted data
SELECT TOP 5*
FROM [dbo].[ABE_building_energy]

-- Load top five rows of post-retrofitted data
SELECT TOP 5*
FROM [dbo].[ABE_building_retrofit_energy]

-- What are highest to lowest total energy consumption by day in the building, and their percentages
SELECT 
    Day,
    ROUND (SUM(Energy_consumed_kWh), 2) AS Total_Energy_kWh,
    ROUND(SUM(Energy_consumed_kWh) * 100.0 / SUM(SUM(Energy_consumed_kWh)) OVER (), 2) AS Percent_of_Total
FROM [dbo].[ABE_building_energy]
GROUP BY Day
ORDER BY Total_Energy_kWh DESC;

-- Query energy consumption across rooms in the building
SELECT Office_number,
	SUM (Energy_consumed_kWh) as TotalEnergyConsumed
FROM [dbo].[ABE_building_energy]
GROUP BY Office_number 
ORDER BY Office_number ASC

-- Query energy consumption per sqm across rooms in the building
SELECT Office_number,
	SUM (Energy_consumed_per_area_kWh_m_2) as TotalEnergyConsumed
FROM [dbo].[ABE_building_energy]
GROUP BY Office_number 
ORDER BY Office_number ASC

-- Query time interval with highest sum of energy consumption
SELECT Time_interval,
	SUM (Energy_consumed_kWh) as TotalEnergyConsumed
FROM [dbo].[ABE_building_energy]
GROUP BY Time_interval 
ORDER BY TotalEnergyConsumed DESC


-- Query the condition of energy consumption in rooms and their percentages 
SELECT Condition,
	ROUND(SUM (Energy_consumed_kWh), 2) as TotalEnergyConsumed,
	ROUND(SUM(Energy_consumed_kWh) * 100.0 / SUM(SUM(Energy_consumed_kWh)) OVER (), 2) AS Percent_of_Total
FROM [dbo].[ABE_building_energy]
WHERE Condition = 'On sit' OR Condition = 'Not on sit'
GROUP BY Condition 

-- Query the percent decrease of total energy after potential retrofitting
SELECT 
    ROUND ((b.Total_Energy_kWh - r.Total_Retrofit_kWh) / b.Total_Energy_kWh * 100, 2) AS Energy_Percentage
FROM 
    (SELECT SUM(Energy_consumed_kWh) AS Total_Retrofit_kWh FROM [dbo].[ABE_building_retrofit_energy]) r
CROSS JOIN 
	(SELECT SUM(Energy_consumed_kWh) AS Total_Energy_kWh FROM [dbo].[ABE_building_energy]) b;

-- Query the energy consumed before and after retrofitting and their respective percentage reduction
SELECT 
    orig.Office_number, 
    orig.TotalOriginalEnergyConsumed,
    retro.TotalRetrofitEnergyConsumed,
	COALESCE(
        (orig.TotalOriginalEnergyConsumed - retro.TotalRetrofitEnergyConsumed) / 
        NULLIF(orig.TotalOriginalEnergyConsumed, 0) * 100,
        0
    ) as PercentReduction
FROM 
    (SELECT 
        Office_number, 
        SUM(Energy_consumed_per_area_kWh_m_2) as TotalOriginalEnergyConsumed
     FROM 
        [dbo].[ABE_building_energy] 
     GROUP BY
        Office_number) orig
LEFT JOIN 
    (SELECT 
        Office_number, 
        SUM(Energy_consumed_per_area_kWh_m_2) as TotalRetrofitEnergyConsumed
     FROM 
        [dbo].[ABE_building_retrofit_energy]
     GROUP BY
        Office_number) retro
ON orig.Office_number = retro.Office_number
ORDER BY
    orig.Office_number ASC;

-- What is the total energy consumed before retrofitting in year 2024 and 2025
	SELECT TotalEnergyConsumed2024, TotalEnergyConsumed2025
	FROM 
	(SELECT 
	ROUND(SUM (Energy_consumed_kWh), 2) as TotalEnergyConsumed2024
	FROM [dbo].[ABE_building_energy]
	WHERE Year(Date) = 2024) b
	CROSS JOIN
	(SELECT 
	ROUND(SUM (Energy_consumed_kWh), 2) as TotalEnergyConsumed2025
	FROM [dbo].[ABE_building_energy]
	WHERE Year(Date) = 2025) j;

	-- Query the total sum of energy consumed before and after retrofitting in the building
	SELECT TotalEnergyConsumed, TotalRetrofitEnergy
	FROM 
	(SELECT 
	ROUND(SUM (Energy_consumed_kWh), 2) as TotalEnergyConsumed
	FROM [dbo].[ABE_building_energy]) b
	CROSS JOIN
	(SELECT 
	ROUND(SUM (Energy_consumed_kWh), 2) as TotalRetrofitEnergy
	FROM [dbo].[ABE_building_retrofit_energy]) j;

	-- Query the total energy consumed based on 'condition' and 'room number'
	SELECT Office_number, Condition, ROUND(SUM (Energy_consumed_kWh), 2) as TotalEnergyConsumed
	FROM dbo.ABE_building_energy
	WHERE Condition = 'On sit' OR Condition = 'Not on sit'
	GROUP BY Office_number, Condition
	ORDER BY Office_number ASC

 -- Get each appliance total energy consumption in the building before retrofitting 
SELECT 
'Fridge' AS Appliance,
ROUND(SUM(Fridge_W), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy

UNION ALL

SELECT 
    'AC' AS Appliance,
    ROUND(SUM(AC_W), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy

UNION ALL

SELECT 
    'Desktop' AS Appliance,
    ROUND(SUM(Desktop_W), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy

UNION ALL

SELECT 
    'Fan' AS Appliance,
    ROUND(SUM(Fan_W), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy

UNION ALL

SELECT 
    'Laptop' AS Appliance,
    ROUND(SUM(Laptop_W), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy

UNION ALL

SELECT 
    'Bulb' AS Appliance,
    ROUND(SUM(Lighting_W), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy

UNION ALL

SELECT 
    'Phone' AS Appliance,
    ROUND(SUM(Phone_W), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy

-- Query the total energy consumed in each week
SELECT 
'Week 1' AS Week_no,
ROUND(SUM(Energy_consumed_kWh), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy
WHERE Date >= '2024-12-02' and Date <= '2024-12-06'

UNION ALL

SELECT 
    'Week 2' AS Week_no,
ROUND(SUM(Energy_consumed_kWh), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy
WHERE Date >= '2024-12-09' and Date <= '2024-12-13'
UNION ALL

SELECT 
    'Week 3' AS Week_no,
ROUND(SUM(Energy_consumed_kWh), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy
WHERE Date >= '2024-12-16' and Date <= '2024-12-20'
UNION ALL


SELECT 
    'Week 4' AS Week_no,
ROUND(SUM(Energy_consumed_kWh), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy
WHERE Date >= '2025-01-06' and Date <= '2025-01-10'
UNION ALL

SELECT 
    'Week 5' AS Week_no,
ROUND(SUM(Energy_consumed_kWh), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy
WHERE Date >= '2025-01-13' and Date <= '2025-01-17'
UNION ALL 

SELECT 
    'Week 6' AS Week_no,
ROUND(SUM(Energy_consumed_kWh), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy
WHERE Date >= '2025-01-20' and Date <= '2025-01-24'
UNION ALL

SELECT 
    'Week 7' AS Week_no,
ROUND(SUM(Energy_consumed_kWh), 2) AS TotalEnergyConsumed
FROM dbo.ABE_building_energy
WHERE Date >= '2025-01-27' and Date <= '2025-01-31'

