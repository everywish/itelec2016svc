require 'test_helper'

class CandidatesControllerTest < ActionController::TestCase
  setup do
    @candidate = candidates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:candidates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create candidate" do
    assert_difference('Candidate.count') do
      post :create, candidate: { address: @candidate.address, age: @candidate.age, career: @candidate.career, city: @candidate.city, criminal_record: @candidate.criminal_record, district: @candidate.district, education: @candidate.education, gender: @candidate.gender, name: @candidate.name, necid: @candidate.necid, occupation: @candidate.occupation, party: @candidate.party, picture: @candidate.picture }
    end

    assert_redirected_to candidate_path(assigns(:candidate))
  end

  test "should show candidate" do
    get :show, id: @candidate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @candidate
    assert_response :success
  end

  test "should update candidate" do
    patch :update, id: @candidate, candidate: { address: @candidate.address, age: @candidate.age, career: @candidate.career, city: @candidate.city, criminal_record: @candidate.criminal_record, district: @candidate.district, education: @candidate.education, gender: @candidate.gender, name: @candidate.name, necid: @candidate.necid, occupation: @candidate.occupation, party: @candidate.party, picture: @candidate.picture }
    assert_redirected_to candidate_path(assigns(:candidate))
  end

  test "should destroy candidate" do
    assert_difference('Candidate.count', -1) do
      delete :destroy, id: @candidate
    end

    assert_redirected_to candidates_path
  end
end
