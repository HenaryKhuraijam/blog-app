require 'rails_helper'
RSpec.describe 'Test Show user Page', type: :feature do
  describe 'GET Show' do
    before(:each) do
      @user = User.create(name: 'Ranj', photo: 'image1.png', bio: 'bio1', posts_counter: 0)
      @user.save!
      @first_post = Post.create(author: @user, title: 'first post', text: 'post1 text',
                                comments_counter: 0, likes_counter: 0, id: 1111)
      @second_post = Post.create(author: @user, title: 'second post', text: 'post2 text',
                                 comments_counter: 0, likes_counter: 0, id: 1112)
      @third_post = Post.create(author: @user, title: 'third post', text: 'post3 text',
                                comments_counter: 0, likes_counter: 0, id: 1113)
      @fourth_post = Post.create(author: @user, title: 'last post',
                                 text: 'last post text', comments_counter: 0, likes_counter: 0, id: 1114)
      visit(user_path(id: @user.id))
    end
    it 'shows the user username' do
      expect(page).to have_content('Ranj')
    end
    it 'shows the user profile picture' do
      expect(page).to have_css('img[src*="image1.png"]')
    end
    it 'shows the user bio' do
      expect(page).to have_content('bio1')
    end
    it 'shows the number of posts the user has written' do
      expect(page).to have_content('4')
    end
    it 'shows all the posts the user has written' do
      expect(page).to have_content('last post')
      expect(page).to have_content('third post')
      expect(page).to have_content('second post')
    end
    it 'should have button to show all posts' do
      expect(page).to have_link('See all posts')
    end
    it "redirects the user to the post's show page after clickin on it" do
      visit(user_posts_path(@user.id))
      click_link 'first post'
      expect(page).to have_current_path user_post_path(@first_post.author_id, @first_post)
    end
    it "redirects the user to the post's index page after clickin on it" do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user)
    end
  end
end
