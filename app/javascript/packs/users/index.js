const CITIES_FILTER_NAME = 'city_ids';
const SENIORITIES_FILTER_NAME = 'seniorities';

// For delete element from array using method filter
let arrayRemove = (arr, value = '') => arr.filter(ele => ele != value);

let generateParams = obj => {
  let params = new URLSearchParams(document.location.search.substring(1));

  for (const key in obj) {
    obj[key].length > 0 ? params.set(key, obj[key]) : params.delete(key);
  }
  document.location.search = params.toString();
}

let addFollowByFilters = (itemBoxesList, filtersBacket, filterName) => {
  itemBoxesList.forEach(itemBox => {
    let itemFilterLink = itemBox.parentElement;
    let itemCheckbox = itemBox.firstElementChild;
    let itemName = itemCheckbox.value;

    if (itemCheckbox.checked = filtersBacket[filterName].includes(itemName)) {
      itemFilterLink.parentElement.prepend(itemFilterLink);
    }

    itemFilterLink.addEventListener('click', event => {
      if (filtersBacket[filterName].includes(itemName)) {
        filtersBacket[filterName] = arrayRemove(filtersBacket[filterName], itemName);
      } else {
        filtersBacket[filterName].push(itemName);
      }

      generateParams(filtersBacket);
    });
  });
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

addFollowByFilters(cityBoxesList, filters, CITIES_FILTER_NAME);
addFollowByFilters(seniorityBoxesList, filters, SENIORITIES_FILTER_NAME);
