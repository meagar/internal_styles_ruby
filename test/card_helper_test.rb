require 'test_helper'

class InternalStyles::CardHelperTest < ActionView::TestCase
  test '#card_tag with default options produces a card element' do
    assert_dom_equal '<div class="card">foo</div>', card_tag { 'foo' }
  end

  test '#card_tag with id and class produces a card element with the right id and class list' do
    assert_dom_equal '<div id="my-card" class="card card1">foo</div>', card_tag(id: 'my-card', class: 'card1') { 'foo' }
  end

  test '#card with no header produces a card with no header' do
    assert_dom_equal '<div class="card"><div class="card-body">foo</div></div>', card { 'foo' }
  end

  test '#card with a header produces a card with a header' do
    assert_dom_equal '<div class="card"><div class="card-header">header!</div><div class="card-body">foo</div></div>', card('header!') { 'foo' }
  end

  test '#card with header classes adds those classes to the header element' do
    assert_dom_equal '<div class="card"><div class="card-header bar">header!</div><div class="card-body">foo</div></div>', card('header!', header_class: 'bar') { 'foo' }
  end

  test '#card with body classes adds those classes to the body element' do
    assert_dom_equal '<div class="card"><div class="card-header">header!</div><div class="card-body media">foo</div></div>', card('header!', body_class: 'media') { 'foo' }
  end
end
