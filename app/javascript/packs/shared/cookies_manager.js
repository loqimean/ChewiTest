let getCookie = name => {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop().split(';').shift();
}

let addCookie = (key, value) => {
  document.cookie = `${key}=[${value}];SameSite=Lax`;
}

export { getCookie, addCookie }
