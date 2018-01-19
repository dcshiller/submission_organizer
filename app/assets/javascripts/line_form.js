
window.lineFormController = {
  toggleForms: function(){
    return document.querySelectorAll('.toggle_form');
  },

  listenerFor: function(el){
    for (let subel of el.parentNode.parentNode.querySelectorAll('input, select')){
      subel.disabled = !subel.disabled;
    }
    let formParent = el.parentNode.parentNode
    formParent.querySelector('.button').classList.toggle('hidden');
    formParent.querySelector('input.as_input, select.as_input').focus();
  },

  assignEvents: function(){
    let self = this;
    document.addEventListener('turbolinks:load', function(){
      for (let el of self.toggleForms()) {
        el.addEventListener('click', self.listenerFor.bind(this, el));
      }
    })
  }
}

window.lineFormController.assignEvents();
