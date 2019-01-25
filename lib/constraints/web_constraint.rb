class WebConstraint
 def matches?(req)
     !req.headers['Accept'].include?("version")
 end
end