require 'test_helper'

class NotasalumnoasignaturasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notasalumnoasignatura = notasalumnoasignaturas(:one)
  end

  test "should get index" do
    get notasalumnoasignaturas_url
    assert_response :success
  end

  test "should get new" do
    get new_notasalumnoasignatura_url
    assert_response :success
  end

  test "should create notasalumnoasignatura" do
    assert_difference('Notasalumnoasignatura.count') do
      post notasalumnoasignaturas_url, params: { notasalumnoasignatura: { CIInfPer: @notasalumnoasignatura.CIInfPer, idAsig: @notasalumnoasignatura.idAsig, idPer: @notasalumnoasignatura.idPer, idnaa: @notasalumnoasignatura.idnaa } }
    end

    assert_redirected_to notasalumnoasignatura_url(Notasalumnoasignatura.last)
  end

  test "should show notasalumnoasignatura" do
    get notasalumnoasignatura_url(@notasalumnoasignatura)
    assert_response :success
  end

  test "should get edit" do
    get edit_notasalumnoasignatura_url(@notasalumnoasignatura)
    assert_response :success
  end

  test "should update notasalumnoasignatura" do
    patch notasalumnoasignatura_url(@notasalumnoasignatura), params: { notasalumnoasignatura: { CIInfPer: @notasalumnoasignatura.CIInfPer, idAsig: @notasalumnoasignatura.idAsig, idPer: @notasalumnoasignatura.idPer, idnaa: @notasalumnoasignatura.idnaa } }
    assert_redirected_to notasalumnoasignatura_url(@notasalumnoasignatura)
  end

  test "should destroy notasalumnoasignatura" do
    assert_difference('Notasalumnoasignatura.count', -1) do
      delete notasalumnoasignatura_url(@notasalumnoasignatura)
    end

    assert_redirected_to notasalumnoasignaturas_url
  end
end
