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
    $(this).addClass('success')
    $('div.root.expenses').addClass('danger')
    $('div.subcategory.income').slideToggle()
  })
  $('div.root.expenses').on('click', function(){
    $(this).addClass('danger')
    $('div.root.income').addClass('success')
    $('div.subcategory.expenses').slideToggle()
  })
  $('div#fixed').on('click', function(){
    $('div.child.fixed').slideToggle()
    addActive()
  })
  $('div#variable').on('click', function(){
    $('div.child.variable').slideToggle()
    addActive()
  })
  $('div#discretionary').on('click', function(){
    $('div.child.discretionary').slideToggle()
    addActive()
  })
  $('div#life').on('click', function(){
    $('div.child.life').slideToggle()
    addActive()
  })
  $('div#other-exp').on('click', function(){
    $('div.child.other-exp').slideToggle()
    addActive()
  })
  $('div#total-food').on('click', function(){
    $(this).toggleClass('active')
    $('div.leaves.food').slideToggle()
  })
}

function addActive(){
  $('div#fixed').addClass('active')
  $('div#variable').addClass('active')
  $('div#discretionary').addClass('active')
  $('div#life').addClass('active')
  $('div#other-exp').addClass('active')
}

function childCheck(){
  if($('div.child').attr('style') === "display: none;") {
    addActive()
  } 
}