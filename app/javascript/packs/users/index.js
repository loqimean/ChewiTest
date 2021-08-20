import { getCookie, addCookie } from '../shared/cookies_manager'

const CITIES_COOKIES_NAME = 'cities_ids';

let each = (elems, fn) => {
  var i = -1;
  while(++i < elems.length){
    fn(elems[i])
  }
}

function arrayRemove(arr, value) {
    return arr.filter(function(ele){
        return ele != value;
    });
}

let citiesLinks = document.getElementsByClassName('cities_filter_items');
let localCookies = getCookie(CITIES_COOKIES_NAME);
console.log(localCookies);
let selectedSitiesIdsCookies = localCookies ? JSON.parse(localCookies) : [];
console.log(selectedSitiesIdsCookies);

each(citiesLinks, cities_filter_link => {
  let cityCheckbox = cities_filter_link.lastElementChild.firstElementChild;

  cities_filter_link.addEventListener('click', event => {
    let cityCheckbox = cities_filter_link.lastElementChild.firstElementChild;
    let localCookies = getCookie(CITIES_COOKIES_NAME);
    let selectedSitiesIdsCookies = localCookies ? JSON.parse(localCookies) : [];
    let cityId = parseInt(cityCheckbox.value);

    if (selectedSitiesIdsCookies.includes(cityId)) {
      selectedSitiesIdsCookies = arrayRemove(selectedSitiesIdsCookies, cityId);
    } else {
      selectedSitiesIdsCookies.push(cityId);
    }

    addCookie(CITIES_COOKIES_NAME, selectedSitiesIdsCookies);

    cities_filter_link.href = `?${CITIES_COOKIES_NAME}=${selectedSitiesIdsCookies}`;
  });
});
