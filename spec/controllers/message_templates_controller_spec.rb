require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe MessageTemplatesController do
  fixtures :all
  disconnect_sunspot

  describe 'GET index' do
    describe 'When logged in as Administrator' do
      login_fixture_admin

      it 'assigns all message_templates as @message_templates' do
        get :index
        assigns(:message_templates).should eq(MessageTemplate.page(1))
      end
    end

    describe 'When logged in as Librarian' do
      login_fixture_librarian

      it 'assigns all message_templates as @message_templates' do
        get :index
        assigns(:message_templates).should eq(MessageTemplate.page(1))
      end
    end

    describe 'When logged in as User' do
      login_fixture_user

      it 'assigns nil as @message_templates' do
        get :index
        assigns(:message_templates).should be_nil
        response.should be_forbidden
      end
    end

    describe 'When not logged in' do
      it 'assigns nil as @message_templates' do
        get :index
        assigns(:message_templates).should be_nil
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe 'GET show' do
    describe 'When logged in as Administrator' do
      login_fixture_admin

      it 'assigns the requested message_template as @message_template' do
        message_template = FactoryGirl.create(:message_template)
        get :show, params: { id: message_template.id }
        assigns(:message_template).should eq(message_template)
      end
    end

    describe 'When logged in as Librarian' do
      login_fixture_librarian

      it 'assigns the requested message_template as @message_template' do
        message_template = FactoryGirl.create(:message_template)
        get :show, params: { id: message_template.id }
        assigns(:message_template).should eq(message_template)
      end
    end

    describe 'When logged in as User' do
      login_fixture_user

      it 'assigns the requested message_template as @message_template' do
        message_template = FactoryGirl.create(:message_template)
        get :show, params: { id: message_template.id }
        assigns(:message_template).should eq(message_template)
      end
    end

    describe 'When not logged in' do
      it 'assigns the requested message_template as @message_template' do
        message_template = FactoryGirl.create(:message_template)
        get :show, params: { id: message_template.id }
        assigns(:message_template).should eq(message_template)
      end
    end
  end

  describe 'GET new' do
    describe 'When logged in as Administrator' do
      login_fixture_admin

      it 'assigns the requested message_template as @message_template' do
        get :new
        assigns(:message_template).should be_nil
        response.should be_forbidden
      end
    end

    describe 'When logged in as Librarian' do
      login_fixture_librarian

      it 'should not assign the requested message_template as @message_template' do
        get :new
        assigns(:message_template).should be_nil
        response.should be_forbidden
      end
    end

    describe 'When logged in as User' do
      login_fixture_user

      it 'should not assign the requested message_template as @message_template' do
        get :new
        assigns(:message_template).should be_nil
        response.should be_forbidden
      end
    end

    describe 'When not logged in' do
      it 'should not assign the requested message_template as @message_template' do
        get :new
        assigns(:message_template).should be_nil
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe 'GET edit' do
    describe 'When logged in as Administrator' do
      login_fixture_admin

      it 'assigns the requested message_template as @message_template' do
        message_template = FactoryGirl.create(:message_template)
        get :edit, params: { id: message_template.id }
        assigns(:message_template).should eq(message_template)
      end
    end

    describe 'When logged in as Librarian' do
      login_fixture_librarian

      it 'assigns the requested message_template as @message_template' do
        message_template = FactoryGirl.create(:message_template)
        get :edit, params: { id: message_template.id }
        response.should be_forbidden
      end
    end

    describe 'When logged in as User' do
      login_fixture_user

      it 'assigns the requested message_template as @message_template' do
        message_template = FactoryGirl.create(:message_template)
        get :edit, params: { id: message_template.id }
        response.should be_forbidden
      end
    end

    describe 'When not logged in' do
      it 'should not assign the requested message_template as @message_template' do
        message_template = FactoryGirl.create(:message_template)
        get :edit, params: { id: message_template.id }
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe 'POST create' do
    before(:each) do
      @attrs = FactoryGirl.attributes_for(:message_template)
      @invalid_attrs = { status: '' }
    end

    describe 'When logged in as Administrator' do
      login_fixture_admin

      describe 'with valid params' do
        it 'assigns a newly created message_template as @message_template' do
          post :create, params: { message_template: @attrs }
          assigns(:message_template).should be_nil
        end

        it 'should be forbidden' do
          post :create, params: { message_template: @attrs }
          response.should be_forbidden
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved message_template as @message_template' do
          post :create, params: { message_template: @invalid_attrs }
          assigns(:message_template).should be_nil
        end

        it 'should be forbidden' do
          post :create, params: { message_template: @invalid_attrs }
          response.should be_forbidden
        end
      end
    end

    describe 'When logged in as Librarian' do
      login_fixture_librarian

      describe 'with valid params' do
        it 'assigns a newly created message_template as @message_template' do
          post :create, params: { message_template: @attrs }
          assigns(:message_template).should be_nil
        end

        it 'should be forbidden' do
          post :create, params: { message_template: @attrs }
          response.should be_forbidden
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved message_template as @message_template' do
          post :create, params: { message_template: @invalid_attrs }
          assigns(:message_template).should be_nil
        end

        it 'should be forbidden' do
          post :create, params: { message_template: @invalid_attrs }
          response.should be_forbidden
        end
      end
    end

    describe 'When logged in as User' do
      login_fixture_user

      describe 'with valid params' do
        it 'assigns a newly created message_template as @message_template' do
          post :create, params: { message_template: @attrs }
          assigns(:message_template).should be_nil
        end

        it 'should be forbidden' do
          post :create, params: { message_template: @attrs }
          response.should be_forbidden
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved message_template as @message_template' do
          post :create, params: { message_template: @invalid_attrs }
          assigns(:message_template).should be_nil
        end

        it 'should be forbidden' do
          post :create, params: { message_template: @invalid_attrs }
          response.should be_forbidden
        end
      end
    end

    describe 'When not logged in' do
      describe 'with valid params' do
        it 'assigns a newly created message_template as @message_template' do
          post :create, params: { message_template: @attrs }
          assigns(:message_template).should be_nil
        end

        it 'should be forbidden' do
          post :create, params: { message_template: @attrs }
          response.should redirect_to(new_user_session_url)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved message_template as @message_template' do
          post :create, params: { message_template: @invalid_attrs }
          assigns(:message_template).should be_nil
        end

        it 'should be forbidden' do
          post :create, params: { message_template: @invalid_attrs }
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      @message_template = FactoryGirl.create(:message_template)
      @attrs = FactoryGirl.attributes_for(:message_template)
      @invalid_attrs = { status: '' }
    end

    describe 'When logged in as Administrator' do
      login_fixture_admin

      describe 'with valid params' do
        it 'updates the requested message_template' do
          put :update, params: { id: @message_template.id, message_template: @attrs }
        end

        it 'assigns the requested message_template as @message_template' do
          put :update, params: { id: @message_template.id, message_template: @attrs }
          assigns(:message_template).should eq(@message_template)
        end

        it 'moves its position when specified' do
          put :update, params: { id: @message_template.id, message_template: @attrs, move: 'lower' }
          response.should redirect_to(message_templates_url)
        end
      end

      describe 'with invalid params' do
        it 'assigns the requested message_template as @message_template' do
          put :update, params: { id: @message_template.id, message_template: @invalid_attrs }
          response.should render_template('edit')
        end
      end
    end

    describe 'When logged in as Librarian' do
      login_fixture_librarian

      describe 'with valid params' do
        it 'updates the requested message_template' do
          put :update, params: { id: @message_template.id, message_template: @attrs }
        end

        it 'assigns the requested message_template as @message_template' do
          put :update, params: { id: @message_template.id, message_template: @attrs }
          assigns(:message_template).should eq(@message_template)
          response.should be_forbidden
        end
      end

      describe 'with invalid params' do
        it 'assigns the requested message_template as @message_template' do
          put :update, params: { id: @message_template.id, message_template: @invalid_attrs }
          response.should be_forbidden
        end
      end
    end

    describe 'When logged in as User' do
      login_fixture_user

      describe 'with valid params' do
        it 'updates the requested message_template' do
          put :update, params: { id: @message_template.id, message_template: @attrs }
        end

        it 'assigns the requested message_template as @message_template' do
          put :update, params: { id: @message_template.id, message_template: @attrs }
          assigns(:message_template).should eq(@message_template)
          response.should be_forbidden
        end
      end

      describe 'with invalid params' do
        it 'assigns the requested message_template as @message_template' do
          put :update, params: { id: @message_template.id, message_template: @invalid_attrs }
          response.should be_forbidden
        end
      end
    end

    describe 'When not logged in' do
      describe 'with valid params' do
        it 'updates the requested message_template' do
          put :update, params: { id: @message_template.id, message_template: @attrs }
        end

        it 'should be forbidden' do
          put :update, params: { id: @message_template.id, message_template: @attrs }
          response.should redirect_to(new_user_session_url)
        end
      end

      describe 'with invalid params' do
        it 'assigns the requested message_template as @message_template' do
          put :update, params: { id: @message_template.id, message_template: @invalid_attrs }
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @message_template = FactoryGirl.create(:message_template)
    end

    describe 'When logged in as Administrator' do
      login_fixture_admin

      it 'destroys the requested message_template' do
        delete :destroy, params: { id: @message_template.id }
      end

      it 'should be forbidden' do
        delete :destroy, params: { id: @message_template.id }
        response.should be_forbidden
      end
    end

    describe 'When logged in as Librarian' do
      login_fixture_librarian

      it 'destroys the requested message_template' do
        delete :destroy, params: { id: @message_template.id }
      end

      it 'should be forbidden' do
        delete :destroy, params: { id: @message_template.id }
        response.should be_forbidden
      end
    end

    describe 'When logged in as User' do
      login_fixture_user

      it 'destroys the requested message_template' do
        delete :destroy, params: { id: @message_template.id }
      end

      it 'should be forbidden' do
        delete :destroy, params: { id: @message_template.id }
        response.should be_forbidden
      end
    end

    describe 'When not logged in' do
      it 'destroys the requested message_template' do
        delete :destroy, params: { id: @message_template.id }
      end

      it 'should be forbidden' do
        delete :destroy, params: { id: @message_template.id }
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
