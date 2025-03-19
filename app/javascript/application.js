// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {

  const tables = [
    { selector: '#passengers-table', order: [[2, 'asc']], searchPlaceholder: "Search passengers..." },
    { selector: '#rides-table', order: [[2, 'desc']], searchPlaceholder: "Search rides..." }
  ];

  tables.forEach(table => {
    const tableElement = document.querySelector(table.selector);
    if (tableElement) {
      if ($.fn.DataTable.isDataTable(table.selector)) {
        $(table.selector).DataTable().destroy();
      }

      $(table.selector).DataTable({
        paging: true,
        searching: true,
        ordering: true,
        pageLength: 10,
        order: table.order,
        language: {
          searchPlaceholder: table.searchPlaceholder
        },
        scrollX: true
      });
    }
  });

  // Flash message auto-hide after 5 seconds
  const flashMessage = document.querySelector(".alert");
  if (flashMessage) {
    setTimeout(() => {
      flashMessage.style.transition = "opacity 2s ease-in-out";
      flashMessage.style.opacity = "0";
      setTimeout(() => flashMessage.remove(), 2000);
    }, 5000);
  }
});
