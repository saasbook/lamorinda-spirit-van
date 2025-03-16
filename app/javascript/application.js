// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {

  const tableElement = document.querySelector('#passengers-table');
  if (tableElement) {
    if ($.fn.DataTable.isDataTable('#passengers-table')) {
      $('#passengers-table').DataTable().destroy();
    }
    
    $('#passengers-table').DataTable({
      paging: true,
      searching: true,
      ordering: true,
      pageLength: 10,  
      order: [[0, 'asc']],
      language: {
        searchPlaceholder: "Search passengers..."
      },
      scrollX: true
    });
  }
  
  // Flash message auto-hide after 5 seconds
  let flashMessage = document.querySelector(".alert");
  if (flashMessage) {
    setTimeout(() => {
      flashMessage.style.transition = "opacity 2s ease-in-out";
      flashMessage.style.opacity = "0";
      setTimeout(() => flashMessage.remove(), 2000); 
    }, 5000); 
  }
});
