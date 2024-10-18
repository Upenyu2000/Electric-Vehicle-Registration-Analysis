/* Geographic Distribution and Legislative District Analysis of Vehicle Registrations

In this analysis, I explore the geographic distribution of registered vehicles, identifying ownership trends across cities, counties,
and legislative districts.

By examining popular vehicle makes and models, I gain insights into regional preferences and vehicle prevalence. 
This information also has potential policy implications, particularly for electric vehicles (EVs), 
helping highlight registration volumes and preferred vehicle types across different areas. */

SELECT DISTINCT ev."County" AS county,COUNT(ev."VIN") AS county_cars,ev."Make"
FROM public."Electric_Vehicle" AS ev
GROUP BY ev."County", ev."Make"
ORDER BY county_cars DESC;

SELECT DISTINCT ev."City" AS city ,COUNT(ev."VIN") AS city_cars, ev."Make"
FROM public."Electric_Vehicle" AS ev
GROUP BY city,ev."Make"
ORDER BY city_cars DESC;

/*
 Vehicle Characteristics
This analysis focuses on identifying the most common makes and models among registered vehicles. 
Understanding the distribution of vehicle types provides insight into market trends and shifts in consumer preferences.

For businesses in automotive, marketing, or insurance, knowing which models are popular allows for better-targeted marketing strategies,
inventory management, and service offerings. As consumer preferences evolve, 
companies can adapt their product lines and services to meet demand, ensuring they stay ahead of market trends.
*/

SELECT ev."Make" AS make, ev."Model" AS model,ev."Model Year" AS model_year, COUNT(ev."VIN") AS registered_vehicle
FROM public."Electric_Vehicle" AS ev
GROUP BY make,model,model_year
ORDER BY registered_vehicle,model_year DESC;

/*
Model Year Distribution: 
This analysis examines the age of vehicles in a specific region, 
providing valuable insights into whether consumers are buying new or used cars. 
For businesses in automotive, insurance, or finance, understanding vehicle age trends helps tailor services to market demands.

I focused on the top five registered vehicles, as companies typically prioritize models with higher registration numbers. 
Supplying parts or services for vehicles with low registration can lead to increased costs and potential losses. 
By concentrating on the most popular models, businesses can optimize their inventory, enhance profitability, 
and better meet consumer demand in a competitive market. 
This targeted approach ensures that companies invest in vehicles with proven demand, 
minimizing risk while maximizing opportunities for growth.

If older vehicles dominate, companies can offer extended warranties, maintenance plans, or used car financing. 
A trend toward newer models suggests a need for cutting-edge products like advanced insurance policies and accessories 
for the latest vehicles. This data allows businesses to strategically align their offerings with regional consumer behavior.
*/

SELECT ev."Make" AS make, ev."Model" AS model,MAX(ev."Model Year") AS model_year, COUNT(ev."VIN") AS registered_vehicle
FROM public."Electric_Vehicle" AS ev
GROUP BY make,model
ORDER BY registered_vehicle DESC;

/*
I focused on the top five registered vehicles, as companies typically prioritize models with higher registration numbers. 
Supplying parts or services for vehicles with low registration can lead to increased costs and potential losses. 
By concentrating on the most popular models, businesses can optimize their inventory, enhance profitability, 
and better meet consumer demand in a competitive market. 
This targeted approach ensures that companies invest in vehicles with proven demand, 
minimizing risk while maximizing opportunities for growth.
*/

SELECT ev."Make" AS make, ev."Model" AS model,MAX(ev."Model Year") AS model_year, COUNT(ev."VIN") AS registered_vehicle
FROM public."Electric_Vehicle" AS ev
GROUP BY make,model
ORDER BY registered_vehicle DESC
LIMIT(5);

/*
Model Year Distribution: 
In this analysis, I focus on identifying the most purchased car model, which in this case is the Tesla Model Y,
with 44,038 vehicles registered. This insight is critical for companies in industries such as insurance, motor part repairs,
and aftermarket services. 

By knowing the most popular vehicle models, businesses can strategically align their offerings—whether it’s
stocking up on specific spare parts or developing premium services like body kits tailored for Tesla users. 
This niche market presents a significant opportunity to differentiate by catering to the growing Tesla customer base, 
ensuring that the right products and services are available to meet the needs of Tesla owners.

Understanding the trends in vehicle registrations allows companies to optimize their inventory, enhance marketing strategies, 
and establish themselves as leaders in providing specialized solutions for high-demand models like the Tesla Model Y.
*/

SELECT make,model,model_year, MAX(registered_vehicle) AS vehicle_registration
FROM (
		SELECT COUNT(ev."VIN") AS registered_vehicle,ev."Make" AS make, ev."Model" AS model,MAX(ev."Model Year") AS model_year
		FROM public."Electric_Vehicle" AS ev
		WHERE ev."Model" LIKE 'MODEL Y'
		GROUP BY make,model
		ORDER BY registered_vehicle DESC
		) AS subquery
GROUP BY make,model,model_year;
		