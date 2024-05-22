class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Escolha onde os arquivos serão armazenados
  storage :file

  # Defina um diretório onde as imagens serão armazenadas
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Crie versões da imagem com diferentes tamanhos
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :medium do
    process resize_to_fit: [300, 300]
  end

  # Permitir apenas certos tipos de arquivos
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end

