module ApplicationHelper


	def display_task(task)
		@content = content_tag(:td, link_to("#{task.name}", '#'))
		@content << content_tag(:td, link_to("O", task_complete_path(task)))
		content_tag(:tr, @content, class: "#{task.status}")
	end



end
