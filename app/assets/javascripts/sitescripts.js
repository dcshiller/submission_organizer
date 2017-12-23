
function triggerButton(button, row){
  let mode = button.getAttribute('data-mode')
  if (mode == 'add') { addRow(button, row) }
  else if (mode == 'save') { saveForm(button, row) }
}

function addRow(button, row){
  row.querySelectorAll('td.hidden').forEach( function(nextEl) {nextEl.classList.remove('hidden'); } );
  button.setAttribute('data-mode', 'save');
  button.querySelector('i').innerText = 'save';
}

function saveForm(button, row){
  row.querySelectorAll('td').forEach( function(nextEl) {nextEl.classList.add('hidden'); } );
  button.setAttribute('data-mode', 'add');
  button.querySelector('i').innerText = 'add';
}

function locate(el){
  id = el.getAttribute('data-target');
  target = document.querySelector("[data-address='" + id +"']");
  container = document.querySelector('.row').getBoundingClientRect()
  el.style.top = target.getBoundingClientRect().y - container.y + 10;
  el.style.left = target.getBoundingClientRect().x - container.x - 20;
}

document.addEventListener('turbolinks:load', function(){
  for (el of document.querySelectorAll('[data-url]')) {
    el.addEventListener('click', function(e){
      if (e.target.tagName != 'A'){
        window.location = e.currentTarget.getAttribute('data-url');
      }
    } ) 
  }

  for (el of document.querySelectorAll('.left-button')) {
    locate(el)
    window.addEventListener('resize', locate.bind(null, el))
    el.addEventListener('click', triggerButton.bind(null, el, target));
  }
})
