
document.addEventListener("turbo:load", function() {
    // using gon if the controller action hasn't set it causes js errors, so as a hack only load this code on pages where its needed
    if (document.getElementById("ride_passenger_name")){

        // basic autocomplete setup
      $( function() {
        $( "#ride_passenger_name" ).autocomplete({
          source: gon.passengers
        });
      } );

      // edits the other fields upon selecting an autocomplete value
      $( "#ride_passenger_name" ).on( "autocompleteselect", function( event, ui ) {
        document.getElementById('ride_passenger_phone').value=  ui.item.phone;
        document.getElementById('ride_passenger_notes').value=  ui.item.notes;
        document.getElementById('ride_passenger_id').value=  ui.item.id;
      } );
    }
  })

  /*
   // E
   document.addEventListener('change', (event) => {
    if (event.target.matches('#ride_passenger_name')) {
      document.getElementById('ride_notes_date_reserved').value=  gon.passengers;
    }
  });*/