$(function(){
  hideYoKids()
  showSubcategories()
})

function hideYoKids(){
  $('div.subcategory').hide()
  $('div.child').hide()
  $('div.leaves').hide()
}

function showSubcategories(){
  $('div.root.income').on('click', function(){
    if($(this).hasClass('root-inc-clicked')){
      $(this).removeClass('root-inc-clicked')
      $('div.subcategory.income').slideUp()
    } else {
      $(this).addClass('root-inc-clicked')
      $('div.subcategory.income').slideDown()
    }
  })

  $('div.root.expenses').on('click', function(e){
    e.stopPropagation
    if($(this).hasClass('root-exp-clicked')){
      $(this).removeClass('root-exp-clicked')
      $('div.leaves.expenses').slideUp()
      $('div.child.expenses').slideUp()
      $('div.subcategory.expenses').slideUp()
    } else {
      $(this).addClass('root-exp-clicked')
      $('div.subcategory.expenses').slideDown()
    }
  })

  $('div#fixed').on('click', function(){
    $('div.child.fixed').slideToggle()
    addActive(this)
  })

  $('div#variable').on('click', function(){
    $('div.child.variable').slideToggle()
    addActive(this)
  })

  $('div#discretionary').on('click', function(){
    $('div.child.discretionary').slideToggle()
      addActive(this)
  })

  $('div#life').on('click', function(){
    $('div.child.life').slideToggle()
      addActive(this)
  })

  $('div#other-exp').on('click', function(){
    $('div.child.other-exp').slideToggle()
      addActive(this)
  })

  $('div#total-food').on('click', function(){
    $(this).toggleClass('active')
    addActive(this)
    $('div.leaves.food').slideToggle()
  })
}

function addActive(selection){
  if($(selection).hasClass('active')){
      $(selection).removeClass('active')
    } else {
      $(selection).addClass('active')
    }
}

function childCheck(){
  if($('div.child').attr('style') === "display: none;") {
    addActive()
  }
}
