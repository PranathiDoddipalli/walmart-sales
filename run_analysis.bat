@echo off
echo Executing MySQL scripts...
mysql -u root -p WalmartSales -e "source sql/feature_engineering.sql"
mysql -u root -p WalmartSales -e "source sql/analysis_queries.sql"
pause
