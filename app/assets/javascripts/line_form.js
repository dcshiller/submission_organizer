window.lineFormController = {
  toggleForms: function(){
    return document.querySelectorAll('.toggle_form');
  },

  listenerFor: function(el, self){
    let formParent = el.parentNode.parentNode
    for (let form of self.toggleForms()){
      let container = form.parentNode.parentNode;
      if (container.querySelector('.toggle_form') != el) {
        container.querySelector('.button').classList.add('hidden');
        container.querySelector('input, select').disabled = true;
      }
    }
    for (let subel of formParent.querySelectorAll('input, select')){
      subel.disabled = !subel.disabled;
    }
    formParent.querySelector('.button').classList.toggle('hidden');
    formParent.querySelector('input.as_input, select.as_input').focus();
  },

  assignEvents: function(){
    let self = this;
    document.addEventListener('turbolinks:load', function(){
      for (let el of self.toggleForms()) {
        el.addEventListener('click', self.listenerFor.bind(this, el, self));
      }
    })
  }
}

window.lineFormController.assignEvents();
