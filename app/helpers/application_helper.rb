module ApplicationHelper


	def display_task(task)
		@content = content_tag(:td, link_to("#{task.name}", task_path(task)))
		@content << content_tag(:td, link_to("--!--", task_complete_path(task)))
		content_tag(:tr, @content, class: "#{task.status_class} bigger-font")
	end



end
