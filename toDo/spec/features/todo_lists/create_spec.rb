require 'spec_helper'

describe "Creating todo lists" do 

		def create_to_list(options={})
		options[:title] ||= "My to Do List"
		options[:description] ||= "What I need to do"

		visit "/todo_lists"
		click_link "New"
		expect(page).to have_content("Another Thing to Do")

		fill_in "I need to...", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create" 
		
		end 




	it "redirects to the todo list index page on success" do 
		
		create_to_list title: "", description: "Got to Run."
		expect(page).to have_content("Got to Run") 
 
 	end 





	it "displays an error when the todo list has no title" do 
		create_to_list title: "", description: "Got to Run."

		expect(page).to have_content("error") 
		expect(page).to_not have_content("This is what I'm doing.")
	
		visit "/todo_lists" 
		expect(page).to_not have_content("Got to run.")
	end 


	it "displays an error when the title has fewer than 3 characters" do 
		create_to_list title: "Hi", description: "Got to Run."
		
		expect(page).to have_content("error")  
		expect(page).to_not have_content("Got to run.")
		
		visit "/todo_lists" 
		expect(page).to_not have_content("Got to run.")
	end 


		it "displays an error when the description has fewer than 3 characters" do 
		create_to_list title: "Running around", description: "Go"
		
		expect(page).to have_content("error")  
		expect(page).to_not have_content("Go.")
		
		visit "/todo_lists" 
		expect(page).to_not have_content("Go")
	end 


	it "displays an error when the description has no description" do 
		create_to_list title: "Grocery", description: ""

		expect(page).to have_content("error") 
		
		visit "/todo_lists" 
 	end 

end



