const container = $("#speedometer");
let measureUnits = "kph"; // Change between "kph" or "mph"

$(document).ready(function () {
  fetch("../../config.json")
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return response.json();
    })
    .then((data) => (measureUnits = data.config.measureUnits))
    .catch((error) => {
      console.error("Error fetching config.json:", error);
    });
});

window.addEventListener("message", async function (event) {
  let data = event.data;

  switch (data.action) {
    case "toggle":
      setSpeedometer(data.inVehicle);
      break;
    case "update":
      updateSpeedometer(data.speed);
      break;
    default:
      break;
  }
});

function updateMeasureUnits(units) {
  if (units != "kph" || units != "mph") {
    measureUnits = "mph"; // MPH for default.
    return;
  }
  measureUnits = units;
}

function setSpeedometer(inVehicle) {
  if (inVehicle) container.fadeIn(250);
  else container.fadeOut(250);
}

function updateSpeedometer(speed) {
  switch (measureUnits) {
    case "kph":
      speed *= 3.6;
      break;
    case "mph":
      speed *= 2.237;
      break;
    default:
      speed *= 2.237; // MPH for default.
      measureUnits = "mph";
      break;
  }

  $("#value").text(speed.toFixed(0));
  $("#units").text(measureUnits);
}
