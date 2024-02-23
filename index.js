fetch("./version.json")
    .then(response => response.json())
    .then(data => document.head.querySelector("meta[name='version']").content = JSON.stringify(data));