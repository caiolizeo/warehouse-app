require 'rails_helper'

describe 'Visitante navega' do
    it 'usando o menu' do
        visit root_path

        #assert 1
        expect(page).to have_css('nav a', text: 'Início')
        expect(page).to have_css('nav a', text: 'Ver todos os fornecedores')

        #assert 2
        within('nav') do
          expect(page).to have_link('Início', href: root_path)
          expect(page).to have_link('Ver todos os fornecedores')
        end
      end
end