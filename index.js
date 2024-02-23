fetch("./version.json")
    .then(response => response.json())
    .then(data => document.head.querySelector("meta[name='version']").value = JSON.stringify(data));