node(:meta) { 
  {
    status: yield.status,
    code: 400
  }
}
node(:data) do
  nil
end
