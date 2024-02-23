fetch("./version.json")
    .then(response => response.json())
    .then(data => document.head.querySelector("meta[name='version']").innerHTML = JSON.stringify(data));