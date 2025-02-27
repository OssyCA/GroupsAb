async function GetTeams() {
  try {
    const response = await fetch("https://localhost:7224/Teams");

    const data = await response.json();
    console.log(data);

    const ulElement = document.querySelector(".teamList");
    data.forEach((e) => {
      // Loop through the data array
      const li = document.createElement("li");

      li.textContent = `${e.teamId}, ${e.teamName}`; // Set the text content of the li element
      ulElement.appendChild(li);

      const t = document.createElement("p"); // Create a p element to hold the players text
      t.textContent = "Players: ";
      li.appendChild(t);

      e.players.forEach((player) => {
        // Loop through the players array
        const p = document.createElement("p");
        p.classList.add("playerLi");
        p.textContent = `${player.playerName}`;
        li.appendChild(p);
      });
    });
  } catch (error) {
    console.log("Error: ", error);
  }
}

async function GetTest() {
  try {
    const response = await fetch("https://localhost:7224/Tests");

    const data = await response.json();
    console.log(data);

    ulElement = document.querySelector(".testList");
    data.forEach((e) => {
      const li = document.createElement("li");

      li.textContent = `${e.testId}, ${e.pname}`;
      ulElement.appendChild(li);
    });
  } catch (error) {
    console.log("Error: ", error);
  }
}

document
  .getElementById("addPlayerForm")
  .addEventListener("submit", async (e) => {
    e.preventDefault();
    const playerName = document.getElementById("playerName").value;
    const teamId = document.getElementById("teamName").value; // Kontrollera att id matchar ditt HTML-element

    // Match the data to the model
    const data = {
      Pname: playerName,
      Tname: teamId,
    };

    try {
      const response = await fetch("https://localhost:7224/Tests", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      });

      if (response.ok) {
        console.log("test added");
      } else {
        console.error("test not added");
      }
    } catch (error) {
      console.error(error);
    }
  });

GetTest();
GetTeams();
