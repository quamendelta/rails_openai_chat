require "openai"
puts "質問はなんですか？："

input = gets

client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'], log_errors: true )

response = client.chat(
    parameters: {
        model: "gpt-4o", # 使用するモデル
        messages: [{ role: "user", content: input}], # メッセージ
        temperature: 0.7, # 回答のランダム性

        # ストリーミングを使う場合
        stream: proc do |chunk, _bytesize|
            print chunk.dig("choices", 0, "delta", "content")
        end
    })
puts response.dig("choices", 0, "message", "content")