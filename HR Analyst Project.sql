create database project;
drop hr_1;
drop database project;
create database project;
use project;
select * from hr_1;
CREATE TABLE `hr_2` (
  `Employee ID` int DEFAULT NULL,
  `MonthlyIncome` int DEFAULT NULL,
  `MonthlyRate` int DEFAULT NULL,
  `NumCompaniesWorked` int DEFAULT NULL,
  `Over18` text,
  `OverTime` text,
  `PercentSalaryHike` int DEFAULT NULL,
  `PerformanceRating` int DEFAULT NULL,
  `RelationshipSatisfaction` int DEFAULT NULL,
  `StandardHours` int DEFAULT NULL,
  `StockOptionLevel` int DEFAULT NULL,
  `TotalWorkingYears` int DEFAULT NULL,
  `TrainingTimesLastYear` int DEFAULT NULL,
  `WorkLifeBalance` int DEFAULT NULL,
  `YearsAtCompany` int DEFAULT NULL,
  `YearsInCurrentRole` int DEFAULT NULL,
  `YearsSinceLastPromotion` int DEFAULT NULL,
  `YearsWithCurrManager` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 

Alter table hr_2 RENAME COLUMN `Employee ID` to `EmployeeId`;

# Total Number of employees 
select count(employeenumber) from hr_1;

# Total Number of male employess
select count(gender) from hr_1  where gender ="male";

# Total Number of female employess
select count(gender) from hr_1  where gender ="female";

# Total Attriton Count
select count(attrition) from hr_1 where attrition="yes";

# Total Active employees 
select count(attrition) from hr_1 where attrition="no";


# 1.Average Attrition rate for all Departments


select department,concat(round(count(attrition)/avg(employeenumber)*100,2),'%') 
as attritionrate from hr_1 where attrition ="yes"
group by department
;



select a.department,concat(round(avg(a.attrition_y)*100,2),'%')  as attrition_rate from
(select department,attrition, 
case when attrition='Yes' 
then 1
Else 0 
End 
as attrition_y from hr_1) as a
group by a.department;


# 2. Average Hourly rate of Male Research Scientist

select jobrole,Count(gender) as Male,round(avg(hourlyrate),2) as Average_Hourly_rate 
from hr_1 where gender="male" and jobrole="research scientist"
group by jobrole;


# 3.Attrition rate Vs Monthly income stats

select a.department,round(avg(M.monthlyincome),2) as AverageMonthlyincome 
from hr_1 as a 
inner join  hr_2 as M 
on a.employeenumber=m.employeeid
 where attrition="yes" 
 group by department;

# Active numbers rate Vs Monthly income stats

select a.department,round(avg(M.monthlyincome),2) as AverageMonthlyincome
 from hr_1 
as a inner join  hr_2 as M 
on a.employeenumber=m.employeeid 
where attrition="No" 
 group by department;


# 4. Average working years for each Department

select d.department , round(avg(w.totalworkingyears),2) as averageworkingyears 
from hr_1 as d 
left join  hr_2 as w 
on d.employeenumber=w.employeeid  
group by department;

# 5. Job Role Vs Work life balance  
 
 SELECT 
a.JobRole,
count(CASE WHEN b.worklifebalance = 1 THEN 0  END) AS Poor,
count(CASE WHEN b.worklifebalance  = 2 THEN 0 END) AS Average,
count(CASE WHEN b.worklifebalance  = 3 THEN 0  END)  AS Good,
count(CASE WHEN b.worklifebalance  = 4 THEN 0  END) AS Excellent,
COUNT(b.worklifebalance ) AS Total_Employee
FROM
hr_1 AS a
INNER JOIN
hr_2 AS b ON b.EmployeeID = a.EmployeeNumber
group by a.JobRole
order by a.jobrole;

# Extra Job Role Vs Performancerating

 SELECT
a.JobRole,
SUM(CASE WHEN b.PerformanceRating = 1 THEN 1 ELSE 0 END) AS First_Rating_Total,
SUM(CASE WHEN b.PerformanceRating = 2 THEN 1 ELSE 0 END) AS Second_Rating_Total,
SUM(CASE WHEN b.PerformanceRating = 3 THEN 1 ELSE 0 END) AS Third_Rating_Total,
SUM(CASE WHEN b.PerformanceRating = 4 THEN 1 ELSE 0 END) AS Fourth_Rating_Total,
COUNT(b.PerformanceRating) AS Total_Employee
FROM
hr_1 AS a
INNER JOIN
hr_2 AS b ON b.EmployeeID = a.EmployeeNumber
group by a.jobrole;

# 6. Attrition rate Vs Year since last promotion relation

SELECT 
    a.JobRole ,
    CONCAT(FORMAT(AVG(a.attrition_rate) * 100, 2), '%') AS Average_Attrition_Rate,
    FORMAT(AVG(b.YearsSinceLastPromotion), 2) AS Average_YearsSinceLastPromotion
FROM (
    SELECT 
        JobRole,
        CASE 
            WHEN attrition = 'yes' THEN 1
            ELSE 0
        END AS attrition_rate,
        employeenumber
    FROM hr_1
) AS a
INNER JOIN hr_2 AS b ON b.employeeid = a.employeenumber
GROUP BY a.JobRole;

# Attrition rate Vs Year since last promotion relation

select '0-10_years' as YearsRangeSinceLastPromotion,count(y.yearssincelastpromotion) as AttritionCount from hr_1 
as a inner join hr_2 as y on 
a.employeenumber=y.employeeid  where attrition ="yes" and y.yearssincelastpromotion between 0 and 10
union 
select '11-20_years' as YearsRangeSinceLastPromotion,count(y.yearssincelastpromotion) as AttritionCount from hr_1 
as a inner join hr_2 as y on 
a.employeenumber=y.employeeid  where attrition ="yes" and y.yearssincelastpromotion between 11 and 20
union
select '21-30_years' as YearsRangeSinceLastPromotion,count(y.yearssincelastpromotion) as AttritionCount from hr_1 
as a inner join hr_2 as y on 
a.employeenumber=y.employeeid  where attrition ="yes" and y.yearssincelastpromotion between 21 and 30
union
select 'Greater Than 30 years' as YearsRangeSinceLastPromotion,count(y.yearssincelastpromotion) as AttritionCount from hr_1 
as a inner join hr_2 as y on 
a.employeenumber=y.employeeid  where attrition ="yes" and y.yearssincelastpromotion >30




