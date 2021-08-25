const CITIES_FILTER_NAME = 'city_ids';
const SENIORITIES_FILTER_NAME = 'seniorities';

// For delete element from array using method filter
let arrayRemove = (arr, value = '') => arr.filter(ele => ele != value);
let generateLink = obj => {
  let url = '?';

  for( const key in obj) {
    url += (obj[key].length > 0 ? key + '=' + obj[key] + '&' : '');
  }
  return url
}

let cityBoxesList = [...document.getElementsByClassName('city_filter_items')];
let seniorityBoxesList = [...document.getElementsByClassName('seniority_filter_items')];
let citiesFilterStatus = arrayRemove(document.getElementById('cities-filter-status')
                                      .getAttribute('data-filter-status')
                                      .split(','));
let senioritiesFilterStatus = arrayRemove(document.getElementById('seniorities-filter-status')
                                      .getAttribute('data-filter-status')
                                      .split(','));
let filters = {
  city_ids: citiesFilterStatus,
  seniorities: senioritiesFilterStatus
}

cityBoxesList.forEach(cityBox => {
  // Gets city link
  let cityFilterLink = cityBox.parentElement;
  // Gets city checkboxds
  let cityCheckbox = cityBox.firstElementChild;
  let cityId = cityCheckbox.value;

  // Checks if filters was selected (for saving state after reload page)
  cityCheckbox.checked = filters[CITIES_FILTER_NAME].includes(cityId);

  cityFilterLink.addEventListener('click', event => {
    // Checks if was filter selected exists or no
    if (filters[CITIES_FILTER_NAME].includes(cityId)) {
      filters[CITIES_FILTER_NAME] = arrayRemove(filters[CITIES_FILTER_NAME], cityId);
    } else {
      filters[CITIES_FILTER_NAME].push(cityId);
    }

    // Generate link with filter params
    cityFilterLink.href = generateLink(filters);
  });
});



seniorityBoxesList.forEach(seniorityBox => {
  // Gets city link
  let seniorityFilterLink = seniorityBox.parentElement;
  // Gets city checkboxds
  let seniorityCheckbox = seniorityBox.firstElementChild;
  let seniorityName = seniorityCheckbox.value;

  // Checks if filters was selected (for saving state after reload page)
  seniorityCheckbox.checked = filters[SENIORITIES_FILTER_NAME].includes(seniorityName);

  seniorityFilterLink.addEventListener('click', event => {
    // Checks if was filter selected exists or no
    if (filters[SENIORITIES_FILTER_NAME].includes(seniorityName)) {
      filters[SENIORITIES_FILTER_NAME] = arrayRemove(filters[SENIORITIES_FILTER_NAME], seniorityName);
    } else {
      filters[SENIORITIES_FILTER_NAME].push(seniorityName);
    }

    // Generate link with filter params
    seniorityFilterLink.href = generateLink(filters);
  });
});
