require File.dirname(__FILE__) + '/../test_helper'

class DatabaseFormPageTest < Test::Unit::TestCase
  fixtures :pages, :form_responses
  test_helper :login, :pages, :difference

  def setup
    @controller = SiteController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as(:existing)
  end

  def test_should_save_form
    assert_difference(FormResponse, :count) do
      post_form
    end
  end

  def test_should_redirect
    post_form
    assert_response :redirect
    assert_equal "/", @response.headers['Location']
  end

  def test_should_upload_file
    assert_difference(FormResponse, :count) do
      post_form_upload
    end
    assert_equal "upload.txt", FormResponse.find_by_name("uploadtest").form_files.first.filename
  end

  private

  def post_form
    post :show_page, :url => ["contact"], "form_name" => "contact", 
      :redirect_to => "/", :content => { "home_phone" => "111-222-3333", "name" => "nick" }
  end
  
  def post_form_upload
    post :show_page, :url => ["contact"], "form_name" => "uploadtest", 
      :redirect_to => "/", :content => { "home_phone" => "111-222-3333", "name" => "nick", "file" => fixture_file_upload('/files/upload.txt') }
  end
end
