$(function(){
  hideYoKids()
  showSubcategories()
})

function hideYoKids(){
  $('tr.subcategory').hide()
  $('tr.child').hide()
  $('tr.leaves').hide()
}

function showSubcategories(){
  $('tr.root.income').on('click', function(){
    $(this).addClass('success')
    $('tr.root.expenses').addClass('danger')
    $('tr.subcategory.income').slideToggle()
  })
  $('tr.root.expenses').on('click', function(){
    $(this).addClass('danger')
    $('tr.root.income').addClass('success')
    $('tr.subcategory.expenses').slideToggle()
  })
  $('tr#fixed').on('click', function(){
    $('tr.child.fixed').slideToggle()
    addActive()
  })
  $('tr#variable').on('click', function(){
    $('tr.child.variable').slideToggle()
    addActive()
  })
  $('tr#discretionary').on('click', function(){
    $('tr.child.discretionary').slideToggle()
    addActive()
  })
  $('tr#life').on('click', function(){
    $('tr.child.life').slideToggle()
    addActive()
  })
  $('tr#other-exp').on('click', function(){
    $('tr.child.other-exp').slideToggle()
    addActive()
  })
  $('tr#total-food').on('click', function(){
    $(this).toggleClass('active')
    $('tr.leaves.food').slideToggle()
  })
}

function addActive(){
  $('tr#fixed').addClass('active')
  $('tr#variable').addClass('active')
  $('tr#discretionary').addClass('active')
  $('tr#life').addClass('active')
  $('tr#other-exp').addClass('active')
}

function childCheck(){
  if($('tr.child').attr('style') === "display: none;") {
    addActive()
  } 
}