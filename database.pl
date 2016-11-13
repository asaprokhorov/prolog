% country(name, independence, area * 1000 km^2, cities)
% city(name, population * 1000, area km^2 districts)
% district(name, population * 1000, area km^2)
country("Ukraine", 1991, 603, [
	city("Kyiv", 2900, 847, [
		district("Golosiivsky", 232, 160),
		district("Obolonsky", 315, 110),
		district("Pechersky", 140, 19),
		district("Podilsky", 192, 34),
		district("Svyatoshynsky", 334, 102)
	]),
	city("Lviv", 730, 182, [
		district("Zaliznychny", 126, 70),
		district("Lychakivsky", 102, 47),
		district("Shevchenkivsky", 144, 60)
	]),
	city("Kharkiv", 1400, 350, [
		district("Shevchenkivsky", 220, 62),
		district("Kyivsky", 182, 46),
		district("Novobavarsky", 108, 34),
		district("Slobidsky", 146, 24)
	])
]).

country("USA", 1776, 9826, [
	city("New York", 8400, 1214, [
		district("Brooklyn", 2400, 251),
		district("Queens", 2300, 464),
		district("Bronx", 1300, 148),
		district("Manhattan", 1600, 87)
	]),
	city("Chicago", 3000, 606, [
		district("West Side", 480, 135),
		district("South Side", 752, 324),
		district("North Side", 526, 147)
	]),
	city("Los Angeles", 3800, 1300, [
		district("Downtown", 58, 15),
		district("Century City", 182, 70),
		district("Koreatown", 115, 37),
		district("Warner Center", 141, 53)
	])
]).

country("United Kingdom", -1, 244, [
	city("London", 8300, 1572, [
		district("Westminster", 181, 21),
		district("Havering", 230, 112),
		district("Greenwich", 170, 71),
		district("Bexley", 133, 52)
	]),
	city("Manchester", 514, 115, [
		district("City", 112, 15),
		district("Old Trafford", 87, 21),
		district("Salford", 79, 19),
		district("Ancoast", 140, 22),
		district("Rusholme", 96, 38)
	]),
	city("Liverpool", 478, 111, [
		district("Downtown", 53, 15),
		district("Enfield", 120, 33),
		district("Ropewalks", 159, 38),
		district("Wavertree", 146, 25)
	]),
	city("Edinburg", 471, 158, [
		district("Leith", 144, 43),
		district("Dalry", 120, 40),
		district("Newington", 119, 35),
		district("Portobello", 88, 40)
	])
]).

country("Ireland", 1919, 70, [
	city("Dublin", 525, 115, [
		district("Drumkondra", 181, 21),
		district("Rathmines", 174, 42),
		district("Ballsbridge", 170, 52)
	])
]).

country("Netherlands", 1581, 41, [
	city("Amsterdam", 842, 219, [
		district("Westport", 320, 115),
		district("Amstelveen", 267, 63),
		district("Diemen", 255, 41)
	]),
	city("Rotterdam", 603, 319, [
		district("Charlois", 183, 83),
		district("Noord", 124, 72),
		district("Schiedam", 159, 88),
		district("Ijsselmonde", 137, 76)
	])
]).

country("Deuchland", 1990, 357, [
	city("Berlin", 3600, 891, [
		district("Moabit", 520, 183),
		district("Kreuzberg", 713, 197),
		district("Fennpfuhl", 754, 216),
		district("Neukolln", 821, 147),
		district("Wilmersdorf", 792, 158)
	]),
	city("Munich", 1450, 310, [
		district("Moosach", 531, 110),
		district("Laim", 482, 100),
		district("Neubiberg", 437, 100)
	]),
	city("Frankfurt", 732, 248, [
		district("Gallus", 341, 140),
		district("Osten", 391, 108)
	])
]).

country("Monaco", 1814, 0.002, [
	city("Monaco", 37, 2, [
		district("Monte-Carlo", 15, 1),
		district("Les Salines", 9, 0.3),
		district("Les Plages", 13, 0.7)
	])
]).

first(X, [X|_]).
belongs(X, [X|_]).
belongs(X, [H|T]) :- belongs(X, T).
write_list([]).
write_list([H|L]) :- write(H), nl, write_list(L).

city(X) :- country(_, _, _, Cities), belongs(X, Cities).
cities(Country, Cities) :- country(Country, _, _, Cities).

independence(Country, Independence) :- country(Country, Independence, _, _).
countryArea(Country, Area) :- country(Country, _, Area, _).
capital(Country, Capital) :- country(Country, _, _, Cities), first(city(Capital, _, _, _), Cities).
cities(Country, Cities) :- country(Country, _, _, Cities).

cityPopulation(City, Population) :- city(city(City, Population, _, _)).
citiesPopulation([], 0).
citiesPopulation([city(City, CityPopulation, _, _)|T], Population) :- citiesPopulation(T, P1), Population is P1 + CityPopulation.
countryPopulation(Country, Population) :- country(Country, _, _, Cities), citiesPopulation(Cities, Population).

cityArea(City, Area) :- city(city(City, _, Area, _)), !.
districts(City, Districts) :- city(city(City, _, _, Districts)).
cityDensity(City, Density) :- city(city(City, Population, Area, _)), Density is (Population / Area).

district(X) :- city(city(_, _, _, Districts)), belongs(X, Districts).

districtPopulation(District, Population) :- district(district(District, Population, _)).
districtArea(District, Area) :- district(district(District, _, Area)).
districtDensity(District, Density) :- district(district(District, Population, Area)), Density is (Population / Area).

allCountryNames(X) :- findall(Y, country(Y, _, _, _), X).

% findall(X, (countryPopulation(X, P), P > 500), Result). get countrynames with population more than 500
% findall(X, capital(_, X), R). get all capitals.
% findall(X, (capital(_, X), cityPopulation(X, P), P > 1000), R). get capitals with population more than 1000
% findall(X, (city(city(X, P, _, _)), P > 1000), R). get cities withpopulation more than 1000
% findall(X, (district(district(X, _, A)), A > 200), R). get districts with area more than 200

districtMoreThan([district(_, P, _)|T], M) :- P > M, ! ; districtMoreThan(T, M).