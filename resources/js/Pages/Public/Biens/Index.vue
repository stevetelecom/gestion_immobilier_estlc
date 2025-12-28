<template>
    <div class="min-h-screen bg-gray-50">
        <!-- Header -->
        <header class="bg-white shadow sticky top-0 z-50">
            <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <Link href="/" class="text-2xl font-bold text-blue-600">🏠 ImmoGest</Link>
                    
                    <div class="hidden md:flex space-x-8">
                        <Link href="/" class="text-gray-700 hover:text-blue-600">Accueil</Link>
                        <Link href="/biens" class="text-blue-600 font-semibold">Nos Biens</Link>
                        <Link href="/a-propos" class="text-gray-700 hover:text-blue-600">À propos</Link>
                        <Link href="/contact" class="text-gray-700 hover:text-blue-600">Contact</Link>
                    </div>
                    
                    <div class="flex items-center space-x-4">
                        <Link href="/login" class="text-gray-700 hover:text-blue-600 font-medium">
                            Se connecter
                        </Link>
                        <Link href="/register" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
                            S'inscrire
                        </Link>
                    </div>
                </div>
            </nav>
        </header>

        <!-- Filtres de recherche -->
        <section class="bg-white border-b py-6">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <h1 class="text-3xl font-bold mb-6">Nos Biens Disponibles</h1>
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <input 
                        type="text" 
                        placeholder="Rechercher..."
                        class="border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500"
                    >
                    <select class="border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500">
                        <option value="">Tous les types</option>
                        <option value="appartement">Appartement</option>
                        <option value="maison">Maison</option>
                        <option value="bureau">Bureau</option>
                        <option value="studio">Studio</option>
                    </select>
                    <input 
                        type="number" 
                        placeholder="Prix min (FCFA)"
                        class="border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500"
                    >
                    <input 
                        type="number" 
                        placeholder="Prix max (FCFA)"
                        class="border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500"
                    >
                </div>
            </div>
        </section>

        <!-- Liste des biens -->
        <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div 
                    v-for="bien in biens" 
                    :key="bien.id"
                    class="bg-white rounded-lg shadow hover:shadow-xl transition overflow-hidden"
                >
                    <!-- Image -->
                    <div class="relative h-48 overflow-hidden">
                        <img 
                            :src="bien.image" 
                            :alt="bien.titre"
                            class="w-full h-full object-cover hover:scale-110 transition duration-300"
                        >
                        <div class="absolute top-4 right-4 bg-blue-600 text-white px-3 py-1 rounded-full text-sm font-semibold">
                            {{ bien.type }}
                        </div>
                    </div>
                    
                    <!-- Contenu -->
                    <div class="p-6">
                        <h3 class="text-xl font-bold mb-2">{{ bien.titre }}</h3>
                        <p class="text-gray-600 text-sm mb-3">
                            📍 {{ bien.quartier }}, {{ bien.ville }}
                        </p>
                        
                        <div class="flex items-center justify-between text-sm text-gray-600 mb-4">
                            <span>🛏️ {{ bien.chambres }} ch.</span>
                            <span>📏 {{ bien.surface }} m²</span>
                        </div>
                        
                        <div class="flex items-center justify-between">
                            <span class="text-2xl font-bold text-blue-600">
                                {{ bien.prix.toLocaleString() }} FCFA/mois
                            </span>
                        </div>
                        
                        <Link 
                            :href="`/bien/${bien.id}`"
                            class="mt-4 block w-full text-center bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition"
                        >
                            Voir les détails
                        </Link>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-gray-900 text-gray-400 py-8 mt-12">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <p>&copy; 2024 ImmoGest. Tous droits réservés.</p>
            </div>
        </footer>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    biens: Array
});
</script>
