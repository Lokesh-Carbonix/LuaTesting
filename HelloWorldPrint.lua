function update()
    gcs:send_Text(0, "I am still there .....")

    return update, 1000
end

return update()
