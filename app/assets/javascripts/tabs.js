window.tabsController = {
  tabs: function(){
    return document.querySelectorAll('.tab');
  },

  listenerFor: function(el, self){
    let target = document.getElementById(el.getAttribute('data-toggles'));
    target.parentElement.querySelector('.pane.selected').classList.remove('selected');
    target.parentElement.querySelector('.tab.selected').classList.remove('selected');
    target.classList.add('selected');
    el.classList.add('selected')
  },

  assignEvents: function(){
    let self = this;
    document.addEventListener('turbolinks:load', function(){
      for (let el of self.tabs()) {
        el.addEventListener('click', self.listenerFor.bind(this, el, self));
      }
    })
  }
}

window.tabsController.assignEvents();
