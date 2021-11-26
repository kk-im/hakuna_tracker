const timing = () => {
  const countelement = document.getElementById("countdown");
  if (countelement && countelement.dataset.start) {
    const start = countelement.dataset.start;
    var yourDateToGo = new Date(start); //here you're making new Date object
    yourDateToGo.setDate(yourDateToGo.getDate());
    if (countelement.dataset.end) {
      const end = countelement.dataset.end;
      var endDate = new Date(end); //here you're making new Date object
      var timeLeft = endDate - yourDateToGo; //difference between time you set and now in miliseconds
      var days = Math.floor(timeLeft / (1000 * 60 * 60 * 24)); //conversion miliseconds on days
      if (days < 10) days = "0" + days; //if number of days is below 10, programm is writing "0" before 9, that's why you see "09" instead of "9"
      var hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)); //conversion miliseconds on hours
      if (hours < 10) hours = "0" + hours;
      var minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60)); //conversion miliseconds on minutes
      if (minutes < 10) minutes = "0" + minutes;
      var seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);//conversion miliseconds on seconds
      if (seconds < 10) seconds = "0" + seconds;

      countelement.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s"; // putting number of days, hours, minutes and seconds in div,
        //which id is countdown
    } else {
      setInterval( // you're making an interval - a thing, that is updating content after number of miliseconds, that you're writing after comma as second parameter
      function () {

        var currentDate = new Date().getTime(); //same thing as above
        var timeLeft = currentDate - yourDateToGo; //difference between time you set and now in miliseconds

        var days = Math.floor(timeLeft / (1000 * 60 * 60 * 24)); //conversion miliseconds on days
        if (days < 10) days = "0" + days; //if number of days is below 10, programm is writing "0" before 9, that's why you see "09" instead of "9"
        var hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)); //conversion miliseconds on hours
        if (hours < 10) hours = "0" + hours;
        var minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60)); //conversion miliseconds on minutes
        if (minutes < 10) minutes = "0" + minutes;
        var seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);//conversion miliseconds on seconds
        if (seconds < 10) seconds = "0" + seconds;

        countelement.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s"; // putting number of days, hours, minutes and seconds in div,
        //which id is countdown
      }, 1000);
    }

  }
}
export {timing};
