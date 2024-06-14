RSpec.describe ChatsController, type: :controller do
  describe "GET index" do
    it “returns a successful response” do
      get :index
      expect(response).to be_successful
    end
 
    it "assigns @chats" do
      chat = Chat.create(title: "test title")
      get :index
      expect(assigns(:chats)).to eq([chat])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
