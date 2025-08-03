const axios = require("axios");

const getSentence = async () => {
  const response = await axios.get("https://zenquotes.io/api/random");
  return response.data[0].q.split(" ");
};

module.exports = { getSentence };
