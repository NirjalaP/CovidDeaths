USE CovidData;
GO

select * 
from CovidData..CovidDeaths
where continent is not null
order by 3,4


--select * 
--from CovidData..CovidVaccinations
--order by 3,4

-- selecting data 
select location, date, total_cases, new_cases, total_deaths, population
from CovidData..CovidDeaths
order by 1,2


-- Total Cases vs Total Deaths
-- Likelihood of death caused by Covid in diff countries
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidData..CovidDeaths
where location like '%states'
order by 1,2

-- Toatal Cases Vs Population
-- What percentage of population got Covid
select location, date, population, total_cases, (total_cases/population)*100 as PercentagePopulationInfected
from CovidData..CovidDeaths
where location like '%states'
order by 1,2


-- Countries with highest infection rate compared to population
select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as  PercentagePopulationInfected
from CovidData..CovidDeaths
group by location, population
order by PercentagePopulationInfected desc


-- Countries with highest death count per population
select location, max(cast(total_deaths as int)) as TotalDeathCount
from CovidData..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

-- Breaking down by continent
-- Showing the Continents with highest death counts

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from CovidData..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc


-- Global Numbers
select  sum(new_cases)as TotalCases,
sum(cast(new_deaths as int)) as TotalDeaths, 
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from CovidData..CovidDeaths
where continent is not null    
order by 1,2


-- Total Population vs vaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location, dea.date) as RollingPeopleVaccinated
from CovidData..CovidDeaths dea
join CovidData..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null    
order by 1,2

-- Using CTE
with  PopvsVac (Continent, Location, Data, Population, new_vaccinations ,RollingPeopleVaccinated) as 
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location, dea.date) as RollingPeopleVaccinated
from CovidData..CovidDeaths dea
join CovidData..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null    
)
select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac

--Temp table

drop table if exists #PercentPopulationVaccinated
 create table #PercentPopulationVaccinated
 (
 continent nvarchar(255),
 location nvarchar(255),
 date datetime,
 population numeric,
 new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

 insert into #PercentPopulationVaccinated
 select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location, dea.date) as RollingPeopleVaccinated
from CovidData..CovidDeaths dea
join CovidData..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null    

select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


-- creating view to store data for later visualizations
create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (Partition by dea.location, dea.date) as RollingPeopleVaccinated
from CovidData..CovidDeaths dea
join CovidData..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null 

select * 
from PercentPopulationVaccinated

