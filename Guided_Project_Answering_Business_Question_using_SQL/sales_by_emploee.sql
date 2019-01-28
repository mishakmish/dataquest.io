select e.employee_id, 
       e.first_name||' '||e.last_name as emploee_name,
       e.hire_date,
       sum(ince.total) as total_sales
  from employee e inner join customer cust on cust.support_rep_id = e.employee_id
                    inner join invoice ince on ince.customer_id = e.employee_id
    group by e.employee_id
order by 4 desc

