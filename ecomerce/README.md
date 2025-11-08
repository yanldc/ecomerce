# Meu Mercado - App de Anúncios

Um aplicativo Flutter para criar e gerenciar anúncios de produtos com persistência local usando Hive.

## 🚀 Como Executar

### ⚠️ **IMPORTANTE - Para Chrome/Web:**

Para garantir que os dados sejam persistidos corretamente no navegador, sempre execute na mesma porta:

```bash
flutter run -d chrome --web-port=8080
```

### 📱 **Para outras plataformas:**

```bash
# Android
flutter run

# iOS
flutter run -d ios

# Windows
flutter run -d windows
```

## 📋 **Pré-requisitos**

1. Flutter SDK instalado
2. Dependências do projeto:

```bash
flutter pub get
```

3. Gerar adapters do Hive:

```bash
flutter packages pub run build_runner build
```

## ✨ **Funcionalidades**

### 📝 **Gerenciamento de Anúncios**

- ✅ Criar novos anúncios
- ✅ Editar anúncios existentes
- ✅ Remover anúncios
- ✅ Persistência local com Hive

### 📸 **Imagens**

- ✅ Adicionar imagens via câmera ou galeria
- ✅ Preview de imagens nos anúncios
- ⚠️ **Web**: Imagens são temporárias (perdidas ao recarregar)
- ✅ **Mobile**: Imagens persistem permanentemente

### 📤 **Compartilhamento**

- ✅ WhatsApp
- ✅ E-mail
- ✅ SMS

### 🎯 **Interações**

- ✅ Deslizar para editar (esquerda → direita)
- ✅ Deslizar para excluir (direita → esquerda)

## 🛠️ **Tecnologias Utilizadas**

- **Flutter** - Framework de desenvolvimento
- **Hive** - Banco de dados local NoSQL
- **Image Picker** - Seleção de imagens
- **URL Launcher** - Compartilhamento via apps

## 📁 **Estrutura do Projeto**

```
lib/
├── main.dart           # Ponto de entrada da aplicação
├── anuncio_model.dart  # Modelo de dados do anúncio
├── home_page.dart      # Tela principal com lista de anúncios
└── form_screen.dart    # Tela de formulário para criar/editar
```

## 🌐 **Limitações do Web**

- **Câmera**: No navegador, abre seletor de arquivos
- **Imagens**: Não persistem entre sessões (URLs temporárias)
- **Compartilhamento**: Funciona via URLs web dos aplicativos

## 📱 **Testando Funcionalidades Completas**

Para testar todas as funcionalidades (especialmente câmera e persistência de imagens), recomenda-se usar:

1. **Emulador Android/iOS**
2. **Dispositivo físico conectado**
3. **Build para desktop** (Windows/macOS/Linux)

---

**Desenvolvido com Flutter 💙**
