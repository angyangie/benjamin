$(function(){
  hideYoKids()
  showSubcategories()
  // hoverRoot()
})

function hideYoKids(){
  $('tr.subcategory').hide()
}

function showSubcategories(){
  $('tr.root.income').on('click', function(){
    $(this).toggleClass('success')
    $('tr.subcategory.income').slideToggle()
  })
  $('tr.root.expenses').on('click', function(){
    $(this).toggleClass('danger')
    $('tr.subcategory.expenses').slideToggle()
  })
}

function hoverRoot(){
  $('tr.root.income').hover(
    function(){$(this).addClass('success')},
    function(){$(this).removeClass('success')}
  )
  $('tr.root.expenses').hover(
    function(){$(this).addClass('danger')},
    function(){$(this).removeClass('danger')}
  )  
}