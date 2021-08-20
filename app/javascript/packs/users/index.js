const CITIES_FILTER_NAME = 'city_ids';

// For delete element from array using method filter
let arrayRemove = (arr, value = '') => {
    return arr.filter(ele => {
        return ele != value;
    });
}

// Get all links for cities filter
let cityBoxesList = [...document.getElementsByClassName('cities_filter_items')];
// Get cities filter status
let citiesFilterStatus = arrayRemove(document.getElementById('cities-filter-status')
                                      .getAttribute('data-cities-filter-status')
                                      .split(','));
// Create filters object for generating URL
let filters = {
  city_ids: citiesFilterStatus
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
    cityFilterLink.href = `?${CITIES_FILTER_NAME}=${filters[CITIES_FILTER_NAME]}`;
  });
});
