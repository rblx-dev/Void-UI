    local nums = {0.01, 0.05, 0.1, 0.25, 0.5, 1, 2, 5, 10, 20, 50}

    while true do
        for _, num in ipairs(nums) do
            task.wait(0.1)
            local args = {
	        workspace:WaitForChild("Resources"):WaitForChild("Building"):WaitForChild("CashierDesk"),
	        num,
	        "PutCash"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Payment"):WaitForChild("OperatePaymentRE"):FireServer(unpack(args))
        end
    end
end
while true do
    crash()
end
