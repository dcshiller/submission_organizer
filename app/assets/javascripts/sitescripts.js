
function triggerButton(button, row){
  let mode = button.getAttribute('data-mode')
  if (mode == 'add') { addRow(button, row) }
  else if (mode == 'save') { saveForm(button, row) }
}

function addRow(button, row){
  row.querySelectorAll('td.hidden').forEach( function(nextEl) {nextEl.classList.remove('hidden'); } );
  button.setAttribute('data-mode', 'save');
  button.querySelector('i').innerText = 'save';
  button.querySelector('i').classList.add('bounceIn');
  button.querySelector('i').classList.add('animated');
}

function saveForm(button, row){
  id = el.getAttribute('data-target');
  row.querySelectorAll('td').forEach( function(nextEl) {nextEl.classList.add('hidden'); } );
  button.setAttribute('data-mode', 'add');
  form = document.querySelector('form[data-form-id=' + id + ']');
  form.submit();
  button.querySelector('i').innerText = 'add';
}

// function locate(el){
//   id = el.getAttribute('data-target');
//   container = document.querySelector('.row').getBoundingClientRect()
//   // el.style.top = target.getBoundingClientRect().y - container.y + 65;
//   // el.style.left = target.getBoundingClientRect().x - container.x - 20;
// }

document.addEventListener('turbolinks:load', function(){
  for (el of document.querySelectorAll('[data-url]')) {
    let click_type = el.getAttribute('data-click-type') || 'dblclick';
    el.addEventListener(click_type, function(e){
      if (e.target.tagName != 'A'){
        window.location = e.currentTarget.getAttribute('data-url');
      }
    } ) 
  }

  for (el of document.querySelectorAll('.left-button')) {
    let id = el.getAttribute('data-target');
    let target = document.querySelector("[data-address='" + id +"']");
    el.addEventListener('click', triggerButton.bind(null, el, target));
  }
  setTimeout(function(){
      document.querySelector('#menu_bar').addEventListener('mouseenter', function(e){
        e.target.classList.add('ready')
      })}, 200)
})
