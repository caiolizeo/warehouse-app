require 'rails_helper'

describe 'Visitante navega' do
    it 'usando o menu' do
        visit root_path

        #assert 1
        expect(page).to have_css('nav a', text: 'Início')
        expect(page).to have_css('nav a', text: 'Fornecedores')

        #assert 2
        within('nav') do
          expect(page).to have_link('Início', href: root_path)
          expect(page).to have_link('Fornecedores')
        end
      end
end